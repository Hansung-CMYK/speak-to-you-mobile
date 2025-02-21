import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/alert_dialog.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    DialogTest(),
  );
}

class DialogTest extends StatelessWidget {
  const DialogTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
        title: '앱 바 테스트 페이지',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: 'main',
        routes: {'main': (context) => DialogScreen()},
      ),
    );
  }
}

class DialogScreen extends StatelessWidget {
  const DialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: ''),
      body: Center(
          child: Row(
        children: [
          Expanded(
              child: TextButton(
            onPressed: () => {
              showAlertDialog(
                  context: context,
                  title: '기억을 삭제 했습니다.',
                  content: '선택한 대화 내역이 기록에서 사라집니다.')
            },
            style: TextButton.styleFrom(backgroundColor: AppColors.gray200),
            child: Text('alert'),
          )),
          Expanded(
              child: TextButton(
            onPressed: () => {
              showConfirmDialog(
                context: context,
                title: '기억을 삭제할까요?',
                content: '선택한 대화 내역이 기록에서 사라집니다.',
                stack: true,
              )
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.gray200,
            ),
            child: Text('confirm'),
          )),
        ],
      )),
    );
  }
}
