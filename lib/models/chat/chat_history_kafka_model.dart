import 'package:ego/models/chat/chat_history_model.dart';

class ChatHistoryKafka {
  String from;
  String to;
  final int chatRoomId;
  final String content;
  final String contentType;
  final bool mcpEnabled;
  final String messageHash;

  ChatHistoryKafka({
    required this.from,
    required this.to,
    required this.chatRoomId,
    required this.content,
    required this.contentType,
    required this.mcpEnabled,
    required this.messageHash,
  });

  factory ChatHistoryKafka.fromJson(Map<String, dynamic> json) {
    return ChatHistoryKafka(
      from: (json['from'] as String) ?? 'user_id_001',
      to: (json['to'] as String) ?? '1',
      chatRoomId: (json['chatRoomId'] as int) ?? 1,
      content: json['content'] as String,
      contentType: (json['contentType'] as String) ?? 'TEXT',
      mcpEnabled: (json['mcpEnabled'] as bool) ?? false,
      messageHash: (json['hash'] as String?) ?? 'TEMP_HASH',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'chatRoomId': chatRoomId,
      'content': content,
      'contentType': contentType,
      'mcpEnabled': mcpEnabled,
      'hash': messageHash,
    };
  }

  static ChatHistory convertToChatHistory(ChatHistoryKafka kafkaMessage) {
    return ChatHistory(
      uid: kafkaMessage.from,
      chatRoomId: kafkaMessage.chatRoomId,
      content: kafkaMessage.content,
      type: "e",
      messageHash: kafkaMessage.messageHash,
      chatAt: DateTime.now(),
      contentType: kafkaMessage.contentType,
    );
  }
}
