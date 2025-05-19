class MonthlyDiary {
  final int id; // 일기 ID와 동일
  final DateTime createdAt;
  final String path; // 달력에 보여질 이미지 IconPath전달

  MonthlyDiary({
    required this.id,
    required this.createdAt,
    required this.path
  });

  // JSON → Diary (fromJson)
  factory MonthlyDiary.fromJson(Map<String, dynamic> json) {
    return MonthlyDiary(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      path: json['path']
    );
  }
}
