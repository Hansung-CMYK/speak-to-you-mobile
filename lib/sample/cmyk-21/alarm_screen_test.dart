import 'package:ego/screens/alarm/alarm_screen.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() => runApp(AlarmScreenTest());

class AlarmScreenTest extends StatelessWidget {
  const AlarmScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
          title: '알림 테스트 페이지',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: 'Alarm',
          routes: {
            'Alarm': (context) => Consumer(
              builder: (context, ref, child) {
                return AlarmScreen();
              },
            ),
            // 'temp': (context) => TmpScreen(text: "임시 페이지"),
          }
      ),
    );
  }
}