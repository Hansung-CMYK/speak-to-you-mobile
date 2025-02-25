import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime(2000, 1, 1),
            lastDay: DateTime(2025, 12, 31), // TODO: 수정할 것
            focusedDay: DateTime.now(),
          ),
        ],
      )
    );
  }
}