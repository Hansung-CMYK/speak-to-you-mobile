import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EgoInfoModel {
  final String id;
  final String egoIcon;
  final String egoName;
  final String egoBirth;
  final String egoPersonality;
  final String egoSelfIntro;

  EgoInfoModel({
    required this.id,
    required this.egoIcon,
    required this.egoName,
    required this.egoBirth,
    required this.egoPersonality,
    required this.egoSelfIntro,
  });

  // JSON 변환 함수
  factory EgoInfoModel.fromJson(Map<String, dynamic> json) {
    return EgoInfoModel(
      id: json['id'],
      egoIcon: json['egoIcon'],
      egoName: json['egoName'],
      egoBirth: json['egoBirth'],
      egoPersonality: json['egoPersonality'],
      egoSelfIntro: json['egoSelfIntro'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'egoIcon': egoIcon,
      'egoName': egoName,
      'egoBirth': egoBirth,
      'egoPersonality': egoPersonality,
      'egoSelfIntro': egoSelfIntro
    };
  }

  // 현재일로 부터 EGO 생일까지 남은 일자를 계산 합니다.
  int calcRemainingDays(){
    String dateString = this.egoBirth;

    // 문자열을 DateTime으로 변환
    DateTime targetDate = DateFormat('yyyy/MM/dd').parse(dateString);

    DateTime today = DateTime.now();

    int remainingDays = targetDate.difference(today).inDays;

    return remainingDays;
  }
}
