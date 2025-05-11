import 'dart:convert';

class EgoModel {
  final int id;
  final String name;
  final String introduction;
  final String profileImage;
  final String mbti;
  final String personality;
  final DateTime createdAt;

  EgoModel({
    required this.id,
    required this.name,
    required this.introduction,
    required this.profileImage,
    required this.mbti,
    required this.personality,
    required this.createdAt,
  });

  // JSON -> EgoModel
  factory EgoModel.fromJson(Map<String, dynamic> json) {
    return EgoModel(
      id: json['id'],
      name: json['name'],
      introduction: json['introduction'],
      profileImage: json['profileImage'] == "" ? 'assets/image/ego_icon.png' : json['profileImage'],
      mbti: json['mbti'],
      personality: json['personality'],
      createdAt: DateTime.parse(json['createdAt']),  // String -> DateTime 변환
    );
  }

  // EgoModel -> JSON
  Map<String, dynamic> toJson() {
    final String formattedDate =
        '${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';

    return {
      'id': id,
      'name': name,
      'introduction': introduction,
      'profileImage': profileImage,
      'mbti': mbti,
      'personality': personality,
      'createdAt': formattedDate, // YYYY-MM-DD 형식으로 출력
    };
  }
}
