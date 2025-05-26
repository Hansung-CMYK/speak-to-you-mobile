import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceChatSocketClient {
  final String userId;
  final String egoId;
  final String speaker;
  final void Function(Map<String, dynamic>) onMessage;
  final void Function(Uint8List) onAudioChunk;

  late WebSocketChannel _channel;
  bool _isConnected = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _player = AudioPlayer();
  late StreamController<Uint8List> _streamController;

  VoiceChatSocketClient({
    required this.userId,
    required this.egoId,
    required this.speaker,
    required this.onMessage,
    required this.onAudioChunk,
  });

  Future<void> connect() async {
    final url =
        'ws://10.0.2.2:8000/api/ws/voice-chat?user_id=$userId&ego_id=$egoId&spk=$speaker&chat_room_id=1';

    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel.stream.listen(
          (data) {
        try {
          if (data is String) {
            final parsed = jsonDecode(data);
            print("📥 [JSON 수신] $parsed");

            if (parsed['type'] == 'audio_chunk' && parsed['audio_base64'] != null) {
              final base64Str = parsed['audio_base64'];
              final bytes = base64Decode(base64Str);
              print("🎧 base64 디코딩 완료: ${bytes.length} bytes");

              onAudioChunk(bytes);
              _playAudio(bytes);
            } else {
              onMessage(parsed);
            }
          } else if (data is List<int>) {
            final bytes = Uint8List.fromList(data);
            print("📥 [Binary 수신] ${bytes.length} bytes");

            final sample = bytes.take(10).map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
            print("🧪 수신 바이너리 샘플 (앞 10바이트): $sample");

            onAudioChunk(bytes);
            _playAudio(bytes);
          }
        } catch (e, stack) {
          print("⚠️ 수신 처리 에러: $e");
          print(stack);
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

    _isConnected = true;
    print("✅ WebSocket 연결됨");

    await _startMicStream();
  }

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

  void sendPCM(Uint8List pcmBytes, int sampleRate) {
    if (!_isConnected) return;

    final meta = jsonEncode({'sampleRate': sampleRate});
    final metaBytes = utf8.encode(meta);
    final metaLength = metaBytes.length;

    final totalSize = 4 + metaBytes.length + pcmBytes.length;
    final buffer = BytesBuilder();
    final header = ByteData(4)..setUint32(0, metaLength, Endian.little);
    buffer.add(header.buffer.asUint8List());
    buffer.add(metaBytes);
    buffer.add(pcmBytes);

    _channel.sink.add(buffer.toBytes());
  }

  Future<void> _playAudio(Uint8List bytes) async {
    try {
      print("🎧 재생 시도: ${bytes.length} bytes");
      await _player.stop();
      await _player.play(BytesSource(bytes));
      print("✅ 오디오 재생 성공");
    } catch (e) {
      print("❌ 오디오 재생 실패: $e");
    }
  }

  void stopAudio() async {
    try {
      await _player.stop();
      print("🛑 오디오 재생 중지 완료");
    } catch (e) {
      print("⚠️ 오디오 중지 실패: $e");
    }
  }

  Future<void> stop() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    await _streamController.close();
    await _player.dispose();
    _channel.sink.close();
  }
}