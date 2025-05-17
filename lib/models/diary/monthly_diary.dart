class MonthlyDiary {
  final int id;
  final DateTime createdAt;
  final String path;

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
