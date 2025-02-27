import 'package:ego/widgets/calendar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(CalendarIndicatorApp());

class CalendarIndicatorApp extends StatelessWidget {
  const CalendarIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: CalendarIndicator(
              onChanged: (selectedDate) {
                print("선택된 날짜: ${selectedDate.year}년 ${selectedDate.month}월");
              },
            ),
          ),
        ),
      ),
    );
  }
}
