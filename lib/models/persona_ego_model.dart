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
    return {'ego_id': egoId.toString(), 'name': name, 'mbti': mbti, 'interview': interview.expand((list) => list)
        .map((e) => e.toString()) .join()};
  }

  static Future<void> sendPersonaEgoModel(PersonaEgoModel ego) async {
    final url = Uri.parse('${SettingsService().personaUrl}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ego.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('persona 전송 성공');
      final decodedBody = utf8.decode(response.bodyBytes);
      print('응답: $decodedBody');
    } else {
      print('persona 전송 실패: ${response.statusCode}');
      final decodedBody = utf8.decode(response.bodyBytes);
      print('응답: $decodedBody');
    }
  }
}
