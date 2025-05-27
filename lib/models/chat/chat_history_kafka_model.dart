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
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      chatRoomId: json['chatRoomId'] as int? ?? 0,
      content: json['content'] as String? ?? '',
      contentType: json['contentType'] as String? ?? 'TEXT',
      mcpEnabled: json['mcpEnabled'] as bool? ?? false,
      messageHash: json['hash'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'from': from,
    'to': to,
    'chatRoomId': chatRoomId,
    'content': content,
    'contentType': contentType,
    'mcpEnabled': mcpEnabled,
    'hash': messageHash,
  };

  static ChatHistory convertToChatHistory(ChatHistoryKafka kafka) {
    return ChatHistory(
      uid: kafka.from,
      chatRoomId: kafka.chatRoomId,
      content: kafka.content,
      type: 'e',
      chatAt: DateTime.now(),
      isDeleted: false,
      messageHash: kafka.messageHash,
      contentType: kafka.contentType,
    );
  }
}
