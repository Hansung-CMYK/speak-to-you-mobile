class DiaryCollectionModel {
  final String id;
  final List<String> emotions;
  final List<String> diaries;

  DiaryCollectionModel({
    required this.id,
    required this.emotions,
    required this.diaries,
  });

  // JSON 변환 함수 (fromJson)
  factory DiaryCollectionModel.fromJson(Map<String, dynamic> json) {
    return DiaryCollectionModel(
      id: json['id'],
      emotions: List<String>.from(json['emotions'] ?? []),
      diaries: List<String>.from(json['diaries'] ?? []),
    );
  }

  // JSON 변환 함수 (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emotions': emotions,
      'diaries': diaries,
    };
  }
}
