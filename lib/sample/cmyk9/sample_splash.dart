import 'package:ego/theme/theme.dart';
import 'package:ego/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    SampleSplash(),
  );
}

class SampleSplash extends StatelessWidget {
  const SampleSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
          title: 'Ego',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: Splash()
    ));
  }
}