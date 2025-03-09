import 'package:intl/intl.dart';

/// 채팅의 내용 모델
///
/// [id] : Chatting id [String]
/// [content] : Chatting 내용 [String]
/// [time] : Chatting 보낸 시간 [String]
/// [isUser] : Chatting을 User가 작성했는지 여부[bool]
class ChatContentModel {
  final String id;
  final String topic;
  final String content;
  final String time;
  final bool isUser;

  ChatContentModel({
    required this.id,
    required this.topic,
    required this.content,
    required this.time,
    required this.isUser,
  });

  // JSON 변환 함수
  factory ChatContentModel.fromJson(Map<String, dynamic> json) {
    return ChatContentModel(
      id: json['id'],
      topic: json['topic'],
      content: json['name'],
      time: json['email'],
      isUser: json['isUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'content': content,
      'time': time,
      'isUser': isUser,
    };
  }

  /// 대화 내용 시간을 AM HH:MM 형태로 바꿉니다.
  ///
  /// dateStr : 전달받는 시간 형식입니다. (yyyy/MM/dd/HH:mm:ss의 형식을 가집니다.) [String]
  String getAMPMTime() {
    DateTime dateTime = DateFormat('yyyy/MM/dd/HH:mm:ss').parse(this.time);

    return DateFormat('aHH:mm').format(dateTime);
  }
}

