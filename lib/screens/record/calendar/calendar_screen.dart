import 'package:flutter/cupertino.dart';

import '../../../widgets/diarycalendar/diary_calendar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DiaryCalendar(),
        ],
      )
    );
  }
}