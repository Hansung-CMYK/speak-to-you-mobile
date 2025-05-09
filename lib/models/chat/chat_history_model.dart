import 'package:intl/intl.dart';

class ChatHistory {
  final int id;
  final String uid;
  final int chatRoomId;
  final String content;
  final String type; // "U" 또는 "E"
  final DateTime chatAt;
  final bool isDeleted;

  ChatHistory({
    required this.id,
    required this.uid,
    required this.chatRoomId,
    required this.content,
    required this.type,
    required this.chatAt,
    required this.isDeleted,
  });

  /// JSON → ChatHistory
  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    return ChatHistory(
      id: json['id'],
      uid: json['uid'],
      chatRoomId: json['chat_room_id'],
      content: json['content'],
      type: json['type'],
      chatAt: DateTime.parse(json['chat_at']),
      isDeleted: json['is_deleted'],
    );
  }

  /// ChatHistory → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'chat_room_id': chatRoomId,
      'content': content,
      'type': type,
      'chat_at': chatAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  /// 보기 좋은 시간 형식
  String get formattedChatAt => DateFormat('a hh:mm', 'ko').format(chatAt);

}