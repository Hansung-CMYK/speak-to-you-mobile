import 'package:ego/widgets/bottomsheet/calendar_bottom_sheet.dart';
import 'package:ego/widgets/diarycalendar/diary_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 일기를 월별로 확인할 수 있는 캘린더 화면
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  final selectedValueProvider = StateProvider<int>((ref) => 0);

  void _onClickValue(int value) {
    ref.read(selectedValueProvider.notifier).state = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedValue = ref.watch(selectedValueProvider);

    return Stack(
      children: [
        DiaryCalendar(onClickedValue: _onClickValue), // 캘린더 부분
        if (selectedValue != 0)
          CalendarBottomSheet(key: UniqueKey(), diaryId: selectedValue), // 일자를 클릭했을 때, 일기가 띄워지는 하단 부분
      ],
    );
  }
}
