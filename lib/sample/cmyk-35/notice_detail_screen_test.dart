import 'package:ego/screens/notice/notice_detail_screen.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() => runApp(NoticeDetailScreenTest());

class NoticeDetailScreenTest extends StatelessWidget {
  const NoticeDetailScreenTest({super.key});

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
                return NoticeDetailScreen(
                  category: '업데이트',
                  title: '공지사항 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠',
                  date: DateTime(2025, 1, 29),
                );
              },
            ),
            // 'temp': (context) => TmpScreen(text: "임시 페이지"),
          }
      ),
    );
  }
}