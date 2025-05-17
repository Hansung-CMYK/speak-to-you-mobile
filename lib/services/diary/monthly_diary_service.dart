import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ego/models/diary/monthly_diary.dart';
import 'package:ego/utils/constants.dart';

class MonthlyDiaryService {

  static Future<List<MonthlyDiary>> fetchMonthlyDiaries({
    required String userId,
    required int year,
    required int month,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/calendar/$userId?month=$month&year=$year',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonString = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final decodedJson = json.decode(jsonString);
      final List<dynamic> nestedList  = decodedJson['data'];

      final List<MonthlyDiary> diaries = nestedList
          .expand((inner) => inner as List<dynamic>) // 각 월별 리스트 평탄화
          .map((json) => MonthlyDiary.fromJson(json))
          .toList();

      return diaries;
    } else {
      throw Exception('다이어리 데이터를 불러오지 못했습니다. 상태 코드: ${response.statusCode}');
    }
  }
}