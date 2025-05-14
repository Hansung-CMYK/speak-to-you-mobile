import 'dart:convert';
import 'package:ego/utils/constants.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:ego/models/chat/chat_history_kafka_model.dart';

class SocketService {
  late StompClient _stompClient;

  void connect({required Function(ChatHistoryKafka) onMessageReceived, required String uid}) {
    // TODO 현재 밀버스 구현중이므로 uid = 1로 고정하여 전송
    uid = "1";

    _stompClient = StompClient(
      config: StompConfig(
        url: webSocketUrl,
        onConnect: (StompFrame frame) => _onConnect(frame, onMessageReceived, uid),
        onWebSocketError: (error) => print('WebSocket 오류: $error'),
        onStompError: (frame) => print('STOMP 오류: ${frame.body}'),
        onDisconnect: (frame) => print('연결 종료됨'),
        onDebugMessage: (msg) => print('DEBUG: $msg'),
        heartbeatOutgoing: Duration(seconds: 10),
        heartbeatIncoming: Duration(seconds: 10),
      ),
    );

    _stompClient.activate();
  }

  void _onConnect(
      StompFrame frame, Function(ChatHistoryKafka) onMessageReceived, String uid) {
    print('✅ STOMP 연결 성공');

    _stompClient.subscribe(
      destination: '/topic/messages/${uid}',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final data = jsonDecode(frame.body!);
          final message = ChatHistoryKafka.fromJson(data);
          onMessageReceived(message);
        }
      },
    );
  }

  void sendMessage(ChatHistoryKafka message) {
    // TODO 현재 밀버스 구현중이므로 from, to 를 1로 고정하여 전송
    message.from = "1";
    message.to = "1";

    final String jsonBody = jsonEncode(message.toJson());

    _stompClient.send(
      destination: '/app/chat.send',
      body: jsonBody,
    );

    print('메시지 전송 완료');
  }

  void disconnect() {
    _stompClient.deactivate();
  }
}
