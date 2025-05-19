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

  // 일기 생성 요청 mock.ver
  // static Future<Diary> sendDiaryRequest(DiaryRequestModel request) async {
  //   // 임시 딜레이
  //   // await Future.delayed(const Duration(seconds: 2));
  //
  //   // 무조건 더미 반환 (실제 response는 무시)
  //   return Diary(
  //     uid: 'user_account_001',
  //     egoId: 1,
  //     feeling: "불안, 슬픔",
  //     dailyComment:
  //     "오늘의 채팅방 활동, 시간의 흐름, 오류와 혼란이 있었던 오늘, '불안', '슬픔' 감정이 하루를 지배했고, '연습', '오류', '답변', '채팅방', '채팅'이 곁을 맴돌았어요.",
  //     createdAt: '2025-05-18',
  //     keywords: ['연습', '오류', '답변', '채팅방', '채팅'],
  //     topics: [
  //       Topic(
  //         title: "오늘의 채팅방 활동",
  //         content:
  //         "오늘은 아침에 채팅방에 들어가 보았다. 채팅 내용은 대부분 연습용이었지만, 몇 번째 채팅방인지 궁금해졌다. AI가 '세번째 채팅방에서 5월 18일 임을 알려드립니다'라고 말하면서 시간이 조금씩 바뀌는 게 느껴졌다...",
  //       ),
  //       Topic(
  //         title: "시간의 흐름",
  //         content:
  //         "오늘은 시간이 조금씩 바뀌는 게 느껴졌다. AI가 '세번째 채팅방에서 5월 18일 임을 알려드립니다'라고 말하면서, 시간이 5월 18일로 넘어가는 듯했다...",
  //       ),
  //       Topic(
  //         title: "오류와 혼란",
  //         content:
  //         "오늘은 채팅방에서 오류가 발생했다. AI가 '아 왜 오류나지?'라고 말하면서, 내가 모르는 부분이 있다는 걸 깨달았다...",
  //       ),
  //     ],
  //   );
  // }


}