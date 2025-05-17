class Diary {
  final int diaryId;
  final String uid;
  final int egoId;
  final String? feeling;
  final String? dailyComment;
  final DateTime createdAt;

  Diary({
    required this.diaryId,
    required this.uid,
    required this.egoId,
    this.feeling,
    this.dailyComment,
    required this.createdAt,
  });

  // JSON → Diary (fromJson)
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      diaryId: json['diaryId'],
      uid: json['uid'],
      egoId: json['egoId'],
      feeling: json['feeling'],
      dailyComment: json['dailyComment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Diary → JSON (toJson)
  Map<String, dynamic> toJson() {
    return {
      'diaryId': diaryId,
      'uid': uid,
      'egoId': egoId,
      'feeling': feeling,
      'dailyComment': dailyComment,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
