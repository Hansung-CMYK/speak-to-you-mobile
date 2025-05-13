class ChatHistoryKafka {
  final String from;
  final String to;
  final int chatRoomId;
  final String content;
  final String type;
  final bool mcpEnabled;

  ChatHistoryKafka({
    required this.from,
    required this.to,
    required this.chatRoomId,
    required this.content,
    required this.type,
    required this.mcpEnabled,
  });

  factory ChatHistoryKafka.fromJson(Map<String, dynamic> json) {
    return ChatHistoryKafka(
      from: json['from'] as String,
      to: json['to'] as String,
      chatRoomId: json['chat_room_id'] as int,
      content: json['content'] as String,
      type: json['type'] as String,
      mcpEnabled: json['mcpEnabled'] as bool,
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
    };
  }
}
