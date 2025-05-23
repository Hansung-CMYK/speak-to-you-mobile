import 'package:ego/models/diary/diary.dart';
import 'package:ego/services/diary/diary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ego/models/diary/diary_create.dart';

// 하나의 일기 조회를 요청합니다.
final dailyDiaryProvider = FutureProvider.family
    .autoDispose<Diary, ({String userId, int diaryId})>((ref, params) async {
      return await DiaryService.fetchDailyDiary(
        userId: params.userId,
        diaryId: params.diaryId,
      );
    });

// 생성된 일기 Provider
final diaryCreateFutureProvider = FutureProvider.family<Diary, DiaryRequestModel>((ref, request) async {
  final diary = await DiaryService.sendDiaryRequest(request);

  return diary;
});