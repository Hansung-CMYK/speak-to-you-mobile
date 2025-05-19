import 'package:ego/models/diary/diary.dart';
import 'package:ego/services/diary/daily_diary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 하나의 일기를 요청합니다.
final dailyDiaryProvider = FutureProvider.family
    .autoDispose<Diary, ({String userId, int diaryId})>((ref, params) async {
      return await DailyDiaryService.fetchDailyDiary(
        userId: params.userId,
        diaryId: params.diaryId,
      );
    });
