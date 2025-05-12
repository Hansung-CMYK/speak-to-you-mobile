class NotificationModel {
  final String uid; // 사용자 고유 ID
  final int egoId; // 알림 생성한 EGO ID
  final String title; // 알림 제목
  final DateTime date; // 알림 생성 날짜
  final String contentHtml; // 알림 내용 (HTML)
  final bool isDeleted; // 삭제 여부
  final bool isRead; // 읽음 여부

  NotificationModel({
    required this.uid,
    required this.egoId,
    required this.title,
    required this.date,
    required this.contentHtml,
    required this.isDeleted,
    required this.isRead,
  });

  /// JSON → 객체
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      uid: json['uid'] as String,
      egoId: json['ego_id'] as int,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      contentHtml: json['content_html'] as String,
      isDeleted: json['is_deleted'] as bool,
      isRead: json['is_read'] as bool,
    );
  }

  /// 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ego_id': egoId,
      'title': title,
      'date': date.toIso8601String(), // 표준 형식
      'content_html': contentHtml,
      'is_deleted': isDeleted,
      'is_read': isRead,
    };
  }
}