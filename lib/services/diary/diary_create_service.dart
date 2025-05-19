import 'dart:convert';

import 'package:ego/models/diary/diary.dart';
import 'package:ego/models/diary/diary_create.dart';
import 'package:http/http.dart' as http;

import 'package:ego/utils/constants.dart';

class DiaryCreateService{

  // 일기 생성 요청
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


}