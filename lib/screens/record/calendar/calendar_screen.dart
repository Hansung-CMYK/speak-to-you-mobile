import 'package:ego/widgets/bottomsheet/calendar_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/diarycalendar/diary_calendar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Column(
    //     children: [
    //       DiaryCalendar(),
    //       CalendarBottomSheet(),
    //     ],
    //   )
    // );
    return Stack(
      children: [
        DiaryCalendar(),
        CalendarBottomSheet(),
      ],
    );
  }
}