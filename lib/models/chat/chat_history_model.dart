import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ego/models/chat/chat_history_kafka_model.dart';
import 'package:intl/intl.dart';

class ChatHistory {
  final int? id; // 채팅 내역 ID (nullable for new messages)
  final String uid; // 사용자 UID
  final int chatRoomId; // 채팅방 ID
  final String content; // 사용자가 보낸 메시지
  final String type; // 대화 유형 (user, ego, group)
  final DateTime chatAt; // 대화 발생 시간
  final bool isDeleted; // 삭제 여부
  final String? messageHash; // 메시지 해시 (nullable)

  ChatHistory({
    this.id,
    required this.uid,
    required this.chatRoomId,
    required this.content,
    required this.type,
    required this.chatAt,
    this.isDeleted = false,
    this.messageHash,
  });

  /// fromJson
  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    return ChatHistory(
      id: json['id'],
      uid: json['uid'],
      chatRoomId: json['chatRoomId'],
      content: json['content'],
      type: json['type'],
      chatAt: DateTime.parse(json['chatAt']),
      isDeleted: json['isDeleted'] ?? false,
      messageHash: json['messageHash'],
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'chatRoomId': chatRoomId,
      'content': content,
      'type': type,
      'chatAt': chatAt.toIso8601String(),
      'isDeleted': isDeleted,
      if (messageHash != null) 'messageHash': messageHash,
    };
  }

  /// 보기 좋은 시간 형식
  String get formattedChatAt => DateFormat('a hh:mm', 'ko').format(chatAt);

  /// Hash값 생성 알고리즘
  static String generateSHA256(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static ChatHistoryKafka convertToKafka(ChatHistory chat, {required String to, required String type, bool mcpEnabled = false}) {
    return ChatHistoryKafka(
      from: chat.uid,
      to: to,
      chatRoomId: chat.chatRoomId,
      content: chat.content,
      type: type,
      mcpEnabled: mcpEnabled,
      messageHash: chat.messageHash!,
    );
  }
}
