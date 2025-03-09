import 'package:ego/models/chat/chat_content_model.dart';

/// 주제별 대화 내용을 의미합니다.
///
/// id : 주제의 id값 [String]
/// topic : 주제 제목 [String]
/// chats : 나눈 대화 내용 [List]
/// canWriteDiary : 일기 작성 여부 [bool]
/// reason : 일기를 작성할 수 없는 이유[String]
class ChatTopicModel {
  final String id;
  final String mainTopic;
  final String subTopic;
  final List<ChatContentModel> chats;
  final bool canWriteDiary;
  final String? reason;

  ChatTopicModel({
    required this.id,
    required this.mainTopic,
    required this.subTopic,
    required this.chats,
    required this.canWriteDiary,
    this.reason
  });

  // JSON 변환 함수
  factory ChatTopicModel.fromJson(Map<String, dynamic> json) {
    var chatList = json['chats'] as List;
    List<ChatContentModel> chats =
        chatList.map((chat) => ChatContentModel.fromJson(chat)).toList();

    return ChatTopicModel(
      id: json['id'],
      mainTopic: json['topic'],
      subTopic: json['subTopic'],
      chats: chats,
      canWriteDiary: json['canWriteDiary'],
      reason: json['reason']
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> chatsJson =
        chats.map((chat) => chat.toJson()).toList();

    return {
      'id': id,
      'topic': mainTopic,
      'subTopic': subTopic,
      'chats': chatsJson,
      'canWriteDiary': canWriteDiary,
      'reason': reason
    };
  }
}