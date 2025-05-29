import 'dart:convert';

import 'package:ego/services/setting_service.dart';
import 'package:http/http.dart' as http;

class PersonaEgoModel {
  final int egoId;
  final String name;
  final String mbti;
  final List<List<String>> interview;

  PersonaEgoModel({
    required this.egoId,
    required this.name,
    required this.mbti,
    required this.interview,
  });

  Map<String, dynamic> toJson() {
    return {'egoId': egoId, 'name': name, 'mbti': mbti, 'interview': interview};
  }

  static Future<void> sendPersonaEgoModel(PersonaEgoModel ego) async {
    final url = Uri.parse('${SettingsService().dbUrl}/ego/persona');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ego.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('persona 전송 성공');
      print('응답: ${response.body}');
    } else {
      print('persona 전송 실패: ${response.statusCode}');
      print('에러 메시지: ${response.body}');
    }
  }
}
