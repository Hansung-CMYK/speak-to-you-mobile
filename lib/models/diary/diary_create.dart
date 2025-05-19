// 일기 생성을 위한 model
class DiaryRequestModel {
  final String userId;
  final int egoId;
  final DateTime date;

  DiaryRequestModel({
    required this.userId,
    required this.egoId,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'ego_id': egoId,
      'target_date': date.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DiaryRequestModel &&
              runtimeType == other.runtimeType &&
              userId == other.userId &&
              egoId == other.egoId &&
              date == other.date;

  @override
  int get hashCode => userId.hashCode ^ egoId.hashCode ^ date.hashCode;
}