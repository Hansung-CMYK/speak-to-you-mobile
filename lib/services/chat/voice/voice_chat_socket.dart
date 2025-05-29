import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:audioplayers/audioplayers.dart';

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

  Future<void> toggleMic() async {
    _isMicOn = !_isMicOn;
    print(_isMicOn ? "🎙️ 마이크 ON" : "🔇 마이크 OFF");

    if (_isMicOn) {
      _orderedChunks.clear();
      _nextPlayIndex = 0;
      await _player.stop();
      _isPlaying = false;
    } else {
      final silence = Uint8List(3200); // 0.1s silence
      for (int i = 0; i < 5; i++) {
        sendPCM(silence, 16000);
      }
      Timer(const Duration(seconds: 3), () {
        sendPCM(silence, 16000);
      });
    }
  }

  Future<void> connect() async {
    final url =
        'ws://localhost:8000/api/ws/voice-chat?user_id=$userId&ego_id=$egoId&spk=$speaker&chat_room_id=dummy';

    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel.stream.listen(
          (data) {
        try {
          if (data is String) {
            final parsed = jsonDecode(data);
            if (parsed['type'] == 'audio_chunk' && parsed['audio_base64'] != null) {
              final base64Str = parsed['audio_base64'];
              final bytes = base64Decode(base64Str);
              final index = parsed['index'] ?? 0;

              onAudioChunk(bytes); // 시각화 등
              enqueueOrderedChunk(index, bytes);
            } else {
              onMessage(parsed);
            }
          }
        } catch (e) {
          print("❌ WebSocket 데이터 처리 에러: $e");
        }
      },
      onDone: () {
        _isConnected = false;
        print("❌ WebSocket 종료됨");
      },
      onError: (err) {
        _isConnected = false;
        print("❌ WebSocket 오류: $err");
      },
    );

    _isConnected = true;
    await _startMicStream();
  }

  Future<void> _startMicStream() async {
    final micPermission = await Permission.microphone.request();
    if (!micPermission.isGranted) {
      print("❌ 마이크 권한 거부됨");
      return;
    }

    _streamController = StreamController<Uint8List>.broadcast();
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

    print("🎙️ 마이크 녹음 시작됨");
  }

  void sendPCM(Uint8List pcmBytes, int sampleRate) {
    if (!_isConnected || !_isMicOn) return;

    final meta = jsonEncode({'sampleRate': sampleRate});
    final metaBytes = utf8.encode(meta);
    final metaLength = metaBytes.length;

    final buffer = BytesBuilder();
    final header = ByteData(4)..setUint32(0, metaLength, Endian.little);
    buffer.add(header.buffer.asUint8List());
    buffer.add(metaBytes);
    buffer.add(pcmBytes);

    _channel.sink.add(buffer.toBytes());
  }

  // 🧠 인덱스 기반으로 청크 저장
  void enqueueOrderedChunk(int index, Uint8List chunk) {
    if (_orderedChunks.containsKey(index)) return; // 중복 방지
    _orderedChunks[index] = chunk;
    _tryPlayNext();
  }

  void _tryPlayNext() async {
    if (_isPlaying || !_orderedChunks.containsKey(_nextPlayIndex)) return;

    final chunk = _orderedChunks.remove(_nextPlayIndex)!;
    _isPlaying = true;

    try {
      print("▶️ 재생: 인덱스 $_nextPlayIndex");
      await _player.play(BytesSource(chunk));
    } catch (e) {
      print("❌ 오디오 재생 실패: $e");
    } finally {
      _isPlaying = false;
      _nextPlayIndex++;
      Future.delayed(const Duration(milliseconds: 5), _tryPlayNext);
    }
  }

  void stopAudio() async {
    try {
      await _player.stop();
      _orderedChunks.clear();
      _isPlaying = false;
      _nextPlayIndex = 0;
    } catch (e) {
      print("❌ 오디오 정지 실패: $e");
    }
  }

  Future<void> stop() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    await _streamController.close();
    await _player.dispose();
    _channel.sink.close();

    _orderedChunks.clear();
    _nextPlayIndex = 0;
    _isPlaying = false;

    print("🧹 연결 종료 및 리소스 정리 완료");
  }
}