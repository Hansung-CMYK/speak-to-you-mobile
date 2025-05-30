import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ego/services/chat/chat_room_service.dart';
import 'package:ego/services/setting_service.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:audioplayers/audioplayers.dart';

const int kFlushBytes = 3200; // 0.1 s @16 kHz (PCM16 mono)

class VoiceChatSocketClient {
  final String userId;
  final int egoId;
  final String speaker;
  final void Function(Map<String, dynamic>) onMessage;
  final void Function(Uint8List) onAudioChunk;

  late WebSocketChannel _channel;
  bool _isConnected = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _player = AudioPlayer();
  late StreamController<Uint8List> _streamController;

  bool _isMicOn = true;

  // 🔊 인덱스 기반 청크 재생 큐
  final Map<int, Uint8List> _orderedChunks = {};
  int _nextPlayIndex = 0;
  bool _isPlaying = false;

  VoiceChatSocketClient({
    required this.userId,
    required this.egoId,
    required this.speaker,
    required this.onMessage,
    required this.onAudioChunk,
  });

  bool get isMicOn => _isMicOn;

  /// 마이크 토글: OFF 시 EOS 전송
  Future<void> toggleMic() async {
    _isMicOn = !_isMicOn;
    print(_isMicOn ? "🎙️ 마이크 ON" : "🔇 마이크 OFF");
    if (!_isMicOn) {
      sendEos();
    } else {
      // 재켜질 때 다시 스트리밍 시작
      await _startMicStream();
    }
  }

  /// 서버 WebSocket 연결
  Future<void> connect() async {
    final chatRoomId =
    await ChatRoomService.fetchChatRoomIdByEgoIdNuserId(userId, egoId);
    final url =
        '${SettingsService().webVoiceUrl}/voice-chat?user_id=$userId&ego_id=$egoId&spk=$speaker&chat_room_id=$chatRoomId';

    _channel = WebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;
    print("✅ WebSocket 연결됨");

    // 메시지 수신 처리
    _channel.stream.listen(
          (data) {
        try {
          if (data is String) {
            final parsed = jsonDecode(data);
            final type = parsed['type'];
            if (type == 'audio_chunk' && parsed['audio_base64'] != null) {
              // index 필드가 서버에서 온다고 가정
              final idx = parsed['index'] is int
                  ? parsed['index'] as int
                  : _nextPlayIndex;
              final bytes = base64Decode(parsed['audio_base64']);
              _enqueueAudio(idx, bytes);
              onAudioChunk(bytes);
            } else if (type == 'cancel_audio') {
              // 서버가 재생 취소를 요청할 때
              stopAudio();
            } else {
              onMessage(parsed);
            }
          } else if (data is List<int>) {
            // 바이너리로 올 때 (인덱스 없으면 순차 재생)
            final bytes = Uint8List.fromList(data);
            final idx = _nextPlayIndex;
            _enqueueAudio(idx, bytes);
            onAudioChunk(bytes);
          }
        } catch (e, st) {
          print("⚠️ 수신 처리 에러: $e\n$st");
        }
      },
      onDone: () {
        _isConnected = false;
        print("❌ WebSocket 끊김, 재연결 시도 중...");
        Future.delayed(const Duration(seconds: 2), connect);
      },
      onError: (err) {
        _isConnected = false;
        print("🛑 WebSocket 에러: $err");
      },
    );

    // 처음에 마이크 스트리밍 시작
    await _startMicStream();
  }

  /// 마이크 PCM 스트리밍 시작
  Future<void> _startMicStream() async {
    final micPermission = await Permission.microphone.request();
    if (!micPermission.isGranted) {
      print("❌ 마이크 권한 없음");
      return;
    }

    _streamController = StreamController<Uint8List>();
    _streamController.stream.listen((pcmBytes) {
      sendPCM(pcmBytes, 16000);
    });

    await _recorder.openRecorder();
    await _recorder.startRecorder(
      codec: Codec.pcm16,
      sampleRate: 16000,
      numChannels: 1,
      bitRate: 256000,
      toStream: _streamController.sink,
    );

    print("🎙️ 마이크 스트리밍 시작됨");
  }

  /// PCM 청크 전송
  void sendPCM(Uint8List pcmBytes, int sampleRate) {
    if (!_isConnected || !_isMicOn) return;
    final meta = jsonEncode({'sampleRate': sampleRate});
    final metaBytes = utf8.encode(meta);
    final header = ByteData(4)..setUint32(0, metaBytes.length, Endian.little);
    final buf = BytesBuilder()
      ..add(header.buffer.asUint8List())
      ..add(metaBytes)
      ..add(pcmBytes);
    _channel.sink.add(buf.toBytes());
  }

  /// EOS(end-of-speech) 전송
  void sendEos() {
    if (!_isConnected) return;
    _channel.sink.add(jsonEncode({'eos': true}));
    print("📤 EOS 전송");
  }

  /// 인덱스 순서대로 재생 큐에 넣기
  void _enqueueAudio(int index, Uint8List bytes) {
    _orderedChunks[index] = bytes;
    _tryPlayNext();
  }

  /// 재생 가능한 다음 인덱스가 있다면 재생
  void _tryPlayNext() {
    if (_isPlaying) return;
    final bytes = _orderedChunks[_nextPlayIndex];
    if (bytes == null) return;

    _orderedChunks.remove(_nextPlayIndex);
    _nextPlayIndex++;
    _isPlaying = true;

    _player.play(BytesSource(bytes)).then((_) {
      _isPlaying = false;
      _tryPlayNext();
    }).catchError((e) {
      print("❌ 오디오 재생 실패: $e");
      _isPlaying = false;
    });
  }

  /// 재생 중지: 버퍼 비우고 플레이어 멈춤
  Future<void> stopAudio() async {
    try {
      await _player.stop();
      _orderedChunks.clear();
      _nextPlayIndex = 0;
      _isPlaying = false;
      print("🛑 오디오 재생 중지 및 버퍼 초기화");
    } catch (e) {
      print("⚠️ stopAudio 실패: $e");
    }
  }

  /// 연결 종료 및 리소스 정리
  Future<void> stop() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    await _streamController.close();
    await _player.dispose();
    _channel.sink.close();
    print("🧹 전체 종료 완료");
  }
}