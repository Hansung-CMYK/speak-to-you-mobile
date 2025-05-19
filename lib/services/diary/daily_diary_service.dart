import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ego/utils/constants.dart';

import 'package:ego/models/diary/diary.dart';

class DailyDiaryService {
  /**
   * 하나의 일기 객체를 조회합니다.
   * */
  static Future<Diary> fetchDailyDiary({
    required String userId,
    required int diaryId,
  }) async {
    final uri = Uri.parse('$baseUrl/diary/$userId/$diaryId');

    final response = await http.post(uri);

    if (response.statusCode == 200) {
      final jsonString = utf8.decode(response.bodyBytes);
      final decodedJson = json.decode(jsonString);
      final Diary diary = Diary.fromJson(decodedJson['data']);

      return diary;
    } else {
      throw Exception('다이어리 데이터를 불러오지 못했습니다. 상태 코드: ${response.statusCode}');
    }
  }
}
