import 'dart:async';
import 'dart:convert';
import 'dart:collection';
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

  // 🔊 순서대로 재생할 오디오 큐
  final Queue<Uint8List> _audioQueue = Queue<Uint8List>();
  bool _isPlaying = false;

  VoiceChatSocketClient({
    required this.userId,
    required this.egoId,
    required this.speaker,
    required this.onMessage,
    required this.onAudioChunk,
  });

  bool get isMicOn => _isMicOn;

  /// 마이크 토글 (OFF 시 EOS 전송)
  Future<void> toggleMic() async {
    _isMicOn = !_isMicOn;
    print(_isMicOn ? "🎙️ 마이크 ON" : "🔇 마이크 OFF");
    if (!_isMicOn) {
      sendEos();
    } else {
      await _startMicStream();
    }
  }

  /// WebSocket 연결 및 스트림 리스너
  Future<void> connect() async {
    final chatRoomId =
    await ChatRoomService.fetchChatRoomIdByEgoIdNuserId(userId, egoId);
    final url =
        '${SettingsService().webVoiceUrl}/voice-chat?user_id=$userId&ego_id=$egoId&spk=$speaker&chat_room_id=$chatRoomId';

    _channel = WebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;
    print("✅ WebSocket 연결됨");

    _channel.stream.listen(
          (data) {
        try {
          if (data is String) {
            final parsed = jsonDecode(data);
            final type = parsed['type'];
            switch (type) {
              case 'audio_chunk':
                final base64Str = parsed['audio_base64'] as String?;
                if (base64Str != null) {
                  final bytes = base64Decode(base64Str);
                  onAudioChunk(bytes);
                  _enqueueAudio(bytes);
                }
                break;
              case 'cancel_audio':
                stopAudio();
                break;
              default:
                onMessage(parsed);
            }
          } else if (data is List<int>) {
            final bytes = Uint8List.fromList(data);
            onAudioChunk(bytes);
            _enqueueAudio(bytes);
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

    await _startMicStream();
  }

  /// 마이크 스트리밍 시작
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

  /// PCM 전송
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

  /// 오디오 청크를 큐에 넣고 재생 시도
  void _enqueueAudio(Uint8List bytes) {
    _audioQueue.add(bytes);
    _playNext();
  }

  /// 큐에 남은 다음 청크를 재생
  void _playNext() {
    if (_isPlaying || _audioQueue.isEmpty) return;
    final bytes = _audioQueue.removeFirst();
    _isPlaying = true;
    _player.play(BytesSource(bytes)).then((_) {
      _isPlaying = false;
      _playNext();
    }).catchError((e) {
      print("❌ 오디오 재생 실패: $e");
      _isPlaying = false;
    });
  }

  /// 재생 중지: 플레이어 멈추고 큐 초기화
  Future<void> stopAudio() async {
    try {
      await _player.stop();
      _audioQueue.clear();
      _isPlaying = false;
      print("🛑 오디오 재생 중지 및 버퍼 초기화");
    } catch (e) {
      print("⚠️ stopAudio 실패: $e");
    }
  }

  /// 전체 연결 해제 및 리소스 정리
  Future<void> stop() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    await _streamController.close();
    await _player.dispose();
    _channel.sink.close();
    print("🧹 전체 종료 완료");
  }
}