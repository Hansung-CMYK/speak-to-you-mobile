import 'package:ego/sample/cmyk10/sample_stack_app_bar.dart';
import 'package:ego/screens/email_sent.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    SampleEmailVerification(),
  );
}

class SampleEmailVerification extends StatelessWidget {
  const SampleEmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
          title: 'Ego',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: EmailSentScreen(
            nextPage: SampleStackAppBarScreen(),
          )),
    );
  }
}
