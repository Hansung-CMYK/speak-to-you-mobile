import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/theme.dart';

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() {
  runApp(
    ProviderScope(
      child: StackAppBarTest(),
    ),
  );
}

class StackAppBarTest extends StatelessWidget {
  const StackAppBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
        title: '앱 바 테스트 페이지',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: Consumer(
          builder: (context, ref, child) {
            return SampleStackAppBarScreen();
          },
        ),
      ),
    );
  }
}

class SampleStackAppBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(
        title: '테스트',
      ),
      body: Center(
        child: Text("Test"),
      ),
    );
  }
}
