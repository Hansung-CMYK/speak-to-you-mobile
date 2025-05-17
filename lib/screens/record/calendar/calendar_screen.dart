import 'package:ego/widgets/bottomsheet/calendar_bottom_sheet.dart';
import 'package:ego/widgets/diarycalendar/diary_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarScreen extends ConsumerWidget {
  CalendarScreen({super.key});

  // 날짜 감지 TODO 날짜를 전달 받는 것이 아니라 일별 Diday객체를 감지할 것임 + 거기서 diaryid로 ValendarBottomSheet에서 일기 원본 조회
  final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

  void _onClickDate(WidgetRef ref, DateTime date) {
    ref.read(selectedDateProvider.notifier).state = date;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        DiaryCalendar(
          onClickDate: (date) => _onClickDate(ref, date),
        ),
        CalendarBottomSheet(),
      ],
    );
  }
}