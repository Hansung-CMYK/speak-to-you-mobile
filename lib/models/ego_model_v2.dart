import 'dart:convert';
import 'dart:typed_data';

class EgoModelV2 {
  int? id;
  final String name;
  final String introduction;
  Uint8List? profileImage; // base64 인코딩된 이미지
  final String mbti;
  final DateTime? createdAt;
  final int? likes;
  List<String>? personalityList; // 성격 리스트 (util_function에 나열되어 있음)
  int? rating; //user가 평가한 점수
  String? relation; // Ego와 사용자의 관계
  bool? isLiked; // 해당 ego의 좋아요를 눌렀는가

  EgoModelV2({
    this.id,
    required this.name,
    required this.introduction,
    this.profileImage,
    required this.mbti,
    this.createdAt,
    this.likes,
    this.personalityList,
    this.rating,
    this.relation,
    this.isLiked
  });

  /// JSON → Ego 객체
  factory EgoModelV2.fromJson(Map<String, dynamic> json) {
    return EgoModelV2(
      id: json['id'] as int,
      name: json['name'] as String,
      introduction: json['introduction'] as String,
      profileImage: json['profileImage'] != null
          ? base64Decode(json['profileImage'])
          : null,
      mbti: json['mbti'] as String,
      createdAt:
      json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      likes: json['likes'] != null ? json['likes'] as int : 0,
      personalityList:
      json['personalityList'] != null
          ? List<String>.from(json['personalityList'])
          : [],
      rating: json['rating'],
      relation: json['relation'],
      isLiked: json['isLiked'],
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
      'rating' : rating,
      'isLiked' : isLiked,
      'relation' : relation,
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