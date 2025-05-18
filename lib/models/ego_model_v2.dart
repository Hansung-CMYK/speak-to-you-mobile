import 'dart:convert';
import 'dart:typed_data';

class EgoModelV2 {
  final String name;
  final String introduction;
  final Uint8List? profileImage; // base64 인코딩된 이미지
  final String mbti;
  final DateTime? createdAt;
  final int? likes;
  final List<String>? personalityList;

  EgoModelV2({
    required this.name,
    required this.introduction,
    this.profileImage,
    required this.mbti,
    this.createdAt,
    this.likes,
    this.personalityList,
  });

  /// JSON → Ego 객체
  factory EgoModelV2.fromJson(Map<String, dynamic> json) {
    return EgoModelV2(
      name: json['name'] as String,
      introduction: json['introduction'] as String,
      profileImage: base64Decode(json['profileImage']),
      mbti: json['mbti'] as String,
      createdAt:
      json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      likes: json['likes'] != null ? json['likes'] as int : 0,
      personalityList:
      json['personalityList'] != null
          ? List<String>.from(json['personalityList'])
          : [],
    );
  }

  /// Ego 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'introduction': introduction,
      'profileImage': profileImage != null ? base64Encode(profileImage!) : null,
      'mbti': mbti,
      'createdAt': createdAt?.toIso8601String(),
      'likes': likes,
      'personalityList': personalityList,
    };
  }

  String genPersonalityListToString(){
    var personalityList = this.personalityList ?? [];
    return personalityList.join(', ');
  }

  // 현재일로 부터 EGO 생일까지 남은 일자를 계산 합니다.
  int calcRemainingDays() {
    if (createdAt == null) return 0;

    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);

    // createdAt의 연도를 오늘과 동일하게 설정
    DateTime targetDate = DateTime(today.year, createdAt!.month, createdAt!.day);

    // targetDate가 이미 지났으면 내년으로 설정
    if (targetDate.isBefore(today)) {
      targetDate = DateTime(today.year + 1, createdAt!.month, createdAt!.day);
    }

    int remainingDays = targetDate.difference(today).inDays;

    return remainingDays;
  }
}