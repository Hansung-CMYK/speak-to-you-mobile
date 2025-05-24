import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/**
 * Firebase채팅에서 사용되는 객체 입니다.
 * */
class FirebaseChatModel {
  final String text; // 내용
  final String senderId; // 보내는 사용자의 userId
  final Timestamp? timestamp; // 전송 시간

  FirebaseChatModel({
    required this.text,
    required this.senderId,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender_id': senderId,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  factory FirebaseChatModel.fromMap(Map<String, dynamic> map) {
    return FirebaseChatModel(
      text: map['text'] ?? '',
      senderId: map['sender_id'] ?? '',
      timestamp: map['timestamp'],
    );
  }

  String get formattedTime {
    if (timestamp == null) return "";
    final dateTime = timestamp!.toDate();
    final formatter = DateFormat('a h:mm', 'ko');
    return formatter.format(dateTime);
  }
}
