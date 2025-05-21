import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/diary/diary.dart';
import '../../models/diary/diary_create.dart';
import '../../models/diary/monthly_diary.dart';
import '../../utils/constants.dart';

class DiaryService {
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
      throw Exception('일일 다이어리 데이터를 불러오지 못했습니다. 상태 코드: ${response.statusCode}');
    }
  }

  /**
   * 일기 생성 요청
   * */
  static Future<Diary> sendDiaryRequest(DiaryRequestModel request) async {
    final response = await http.post(
      Uri.parse(diaryCreateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final decodedJson = jsonDecode(json);
      final diary = Diary.fromJson(decodedJson['data']);

      return diary;
    } else {
      throw Exception('일기 생성 실패: ${response.body}');
    }
  }

  /**
   * 새로운 일기를 저장, 기존의 일기를 업데이트 합니다.
   * */
  static Future<Diary> saveDiary(Diary diary) async {
    final response = await http.post(
      Uri.parse('$baseUrl/diary'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(diary.toJson()),
    );

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes);
      final decodedJson = jsonDecode(json);
      final diary = Diary.fromJson(decodedJson['data']);

      return diary;
    } else {
      throw Exception('일기 저장 실패: ${response.body}');
    }
  }

  /**
   * 월별 일기 조회
   * */
  static Future<List<MonthlyDiary>> fetchMonthlyDiaries({
    required String userId,
    required int year,
    required int month,
  }) async {
    final uri = Uri.parse('$baseUrl/calendar/$userId?month=$month&year=$year');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonString = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final decodedJson = json.decode(jsonString);
      final List<dynamic> nestedList = decodedJson['data'];

      final List<MonthlyDiary> diaries =
          nestedList
              .expand((inner) => inner as List<dynamic>) // 각 월별 리스트 평탄화
              .map((json) => MonthlyDiary.fromJson(json))
              .toList();

      return diaries;
    } else {
      throw Exception('월별 다이어리 데이터를 불러오지 못했습니다. 상태 코드: ${response.statusCode}');
    }
  }
}
