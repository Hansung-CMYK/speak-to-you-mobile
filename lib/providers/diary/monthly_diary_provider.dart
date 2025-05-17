import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ego/models/diary/monthly_diary.dart';
import 'package:ego/services/diary/monthly_diary_service.dart';

final monthlyDiaryProvider = FutureProvider.family.autoDispose<List<MonthlyDiary>, ({String userId, int year, int month})>((ref, params) async {
  return await MonthlyDiaryService.fetchMonthlyDiaries(
    userId: params.userId,
    year: params.year,
    month: params.month,
  );
});