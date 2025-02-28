import 'package:ego/widgets/bottomsheet/calendar_bottom_sheet.dart';
import 'package:ego/widgets/diarycalendar/diary_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DiaryCalendar(),
        CalendarBottomSheet(),
      ],
    );
  }
}