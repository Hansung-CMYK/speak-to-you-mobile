
/**
 * 그룹채팅 리스트 아이템 model
 * */
class GroupChatRoomListModel {
  final int id;
  final String uid;
  final String personalityTag;
  final DateTime lastChatAt;
  final bool isDeleted;

  GroupChatRoomListModel({
    required this.id,
    required this.uid,
    required this.personalityTag,
    required this.lastChatAt,
    required this.isDeleted
  });
}
