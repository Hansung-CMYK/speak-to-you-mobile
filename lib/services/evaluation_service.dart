import 'dart:convert';

import 'package:ego/models/evaluation_model.dart';
import 'package:ego/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'setting_service.dart';

class EvaluationService{

  /**
   * 새로운 평가 저장, 기존 평가 업데이트
   * */
  static Future<EvaluationModel> saveEvaluation(EvaluationModel request) async {
    final response = await http.post(
      Uri.parse('${SettingsService().dbUrl}/evaluation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final decodedJson = jsonDecode(json);
      final evaluation = EvaluationModel.fromJson(decodedJson['data']);

      return evaluation;
    } else {
      throw Exception('일기 생성 실패: ${response.body}');
    }
  }


}