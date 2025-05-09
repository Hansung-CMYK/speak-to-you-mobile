class ChatRoomModel {
  final int id;
  final String uid;
  final int egoId;
  final DateTime lastChatAt;
  final bool isDeleted;
  final String? egoName;
  final String? profileImage;

  ChatRoomModel({
    required this.id,
    required this.uid,
    required this.egoId,
    required this.lastChatAt,
    required this.isDeleted,
    this.egoName,
    this.profileImage,
  });

  /// JSON → ChatRoomModel
  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      uid: json['uid'],
      egoId: json['ego_id'],
      lastChatAt: DateTime.parse(json['last_chat_at']),
      isDeleted: json['is_deleted'] as bool,
      egoName: json['ego_name'],
      profileImage: json['profile_image'],
    );
  }

  /// ChatRoomModel → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'ego_id': egoId,
      'last_chat_at': lastChatAt.toIso8601String(),
      'is_deleted': isDeleted,
      'ego_name': egoName,
      'profile_image': profileImage,
    };
  }
}
