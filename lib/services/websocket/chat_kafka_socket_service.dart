import 'dart:convert';
import 'dart:async';
import 'package:ego/models/chat/chat_history_kafka_model.dart';
import 'package:ego/utils/constants.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class SocketService {
  late StompClient _client;
  bool _isConnected = false;

  String _subscribeDestination = '/topic/messages/';
  final String _sendDestination = '/app/chat.send';

  Function(ChatHistoryKafka message)? _onMessage;

  bool get isConnected => _isConnected;

  // 메시지 수신 콜백 등록 메서드
  void onMessageReceived(Function(ChatHistoryKafka message) handler) {
    _onMessage = handler;
  }

  // 실제 연결 수행
  Future<void> connect({required String uid}) async {
    _client = StompClient(
      config: StompConfig(
        url: webSocketUrl,
        onConnect: (frame) => _onConnect(frame, uid),
        onWebSocketError: (dynamic error) {
          print('❌ WebSocket 에러: $error');
        },
        onStompError: (frame) {
          print('⚠️ STOMP 에러: ${frame.body}');
        },
        onDisconnect: (frame) {
          _isConnected = false;
          print('📴 연결 종료');
        },
      ),
    );

    print("🔌 서버 연결 시도 중...");
    _client.activate();

    await _waitForConnection();
  }

  void _onConnect(StompFrame frame, String uid) {
    _isConnected = true;
    print("✅ 서버 연결 성공");

    _subscribeDestination += uid;

    _client.subscribe(
      destination: _subscribeDestination,
      callback: (frame) {
        if (frame.body != null) {
          print("📩 서버 메시지 수신: ${frame.body}");
          final Map<String, dynamic> jsonMap = jsonDecode(frame.body!);
          final chatMessage = ChatHistoryKafka.fromJson(jsonMap);

          print("채팅 메시지: ${chatMessage.content}");
          _onMessage?.call(chatMessage);
        }
      },
    );

    print("📡 구독 시작: $_subscribeDestination");
  }

  void sendMessage(ChatHistoryKafka message) {
    if (!_isConnected) {
      print("🚫 연결되지 않아 메시지 전송 불가");
      return;
    }

    String body = jsonEncode(message.toJson());

    print("📤 메시지 전송: $body");

    _client.send(
      destination: _sendDestination,
      body: body,
    );
  }

  Future<void> disconnect() async {
    print("🧹 연결 종료 중...");
    _client.deactivate();
    _isConnected = false;
  }

  Future<void> _waitForConnection() async {
    const maxWait = 10;
    int waited = 0;
    while (!_isConnected && waited < maxWait) {
      await Future.delayed(Duration(seconds: 1));
      waited++;
    }

    if (!_isConnected) {
      print("❌ 연결 실패");
    }
  }
}
