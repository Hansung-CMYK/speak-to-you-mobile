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
}
