import 'package:ego/models/chat/chat_history_model.dart';

class ChatHistoryKafka {
  String from;
  String to;
  final int chatRoomId;
  final String content;
  final String type;
  final bool mcpEnabled;
  final String messageHash;

  ChatHistoryKafka({
    required this.from,
    required this.to,
    required this.chatRoomId,
    required this.content,
    required this.type,
    required this.mcpEnabled,
    required this.messageHash
  });

  factory ChatHistoryKafka.fromJson(Map<String, dynamic> json) {
    return ChatHistoryKafka(
      from: json['from'] as String,
      to: json['to'] as String,
      chatRoomId: json['chat_room_id'] as int,
      content: json['content'] as String,
      type: json['type'] as String,
      mcpEnabled: json['mcpEnabled'] as bool,
      messageHash: json['messageHash'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'chat_room_id': chatRoomId,
      'content': content,
      'type': type,
      'mcpEnabled': mcpEnabled,
      'messageHash' : messageHash
    };
  }

  static ChatHistory convertToChatHistory(ChatHistoryKafka kafkaMessage) {
    return ChatHistory(
      uid: kafkaMessage.from,
      chatRoomId: kafkaMessage.chatRoomId,
      content: kafkaMessage.content,
      type: "E",
      messageHash: kafkaMessage.messageHash,
      chatAt: DateTime.now(),
    );
  }
}
