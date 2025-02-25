import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/bottomsheet/today_ego_intro.dart';

void main() {
  runApp(SampleTodayEgoIntro());
}

class SampleTodayEgoIntro extends StatelessWidget {
  const SampleTodayEgoIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: 'Ego',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: MyHomePage(),
          ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Check Today Ego!!')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            );

            // API 호출 시뮬레이션
            await Future.delayed(Duration(seconds: 2));

            showTodayEgoIntroSheet(context);
          },
          child: Text('Check Today EGO'),
        ),
      ),
    );
  }
}
