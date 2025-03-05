import 'package:ego/screens/notice/notice_screen.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() => runApp(NoticeScreenTest());

class NoticeScreenTest extends StatelessWidget {
  const NoticeScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
          title: '공지사항 테스트 페이지',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: 'Notice',
          routes: {
            'Notice': (context) => Consumer(
              builder: (context, ref, child) {
                return NoticeScreen();
              },
            ),
            // 'temp': (context) => TmpScreen(text: "임시 페이지"),
          }
      ),
    );
  }
}