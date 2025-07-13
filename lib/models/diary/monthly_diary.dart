/// 월 단위로 일기를 조회시 사용되는 Model 입니다.
/// 월별 일기 조회 시 [일기ID, 날짜, 이모지]만 필요하므로
/// 세개의 정보를 하나의 클래스로 묶어 관리합니다.
class MonthlyDiary {
  final int id; // 일기 ID와 동일 (캘린더에서 일자 클릭시 해당일의 일기를 조회하기 위함)
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
