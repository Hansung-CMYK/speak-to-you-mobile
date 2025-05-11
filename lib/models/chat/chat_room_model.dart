class ChatRoomModel {
  final int id;
  final String uid;
  final int egoId;
  final DateTime lastChatAt;
  final bool isDeleted;

  ChatRoomModel({
    required this.id,
    required this.uid,
    required this.egoId,
    required this.lastChatAt,
    required this.isDeleted,
  });

  // JSON -> ChatRoomModel
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      uid: json['uid'],
      egoId: json['egoId'],
      lastChatAt: DateTime.parse(json['lastChatAt']),
      isDeleted: json['isDeleted'],
    );
  }

  // ChatRoomModel -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'egoId': egoId,
      'lastChatAt': lastChatAt.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}
