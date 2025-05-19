import '../ego_model_v1.dart';

/**
 * ChatRoom값과 EgoModel의 값을 묶어서 관리하기 위한 Class
 * 실제 Json 요청을 하지는 않음
 * */
class ChatRoomListModel {
  final int id;
  final String uid;
  final int egoId;
  final DateTime lastChatAt;
  final bool isDeleted;
  final EgoModelV1 egoModel;

  ChatRoomListModel({
    required this.id,
    required this.uid,
    required this.egoId,
    required this.lastChatAt,
    required this.isDeleted,
    required this.egoModel
  });
}
