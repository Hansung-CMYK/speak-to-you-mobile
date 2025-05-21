import 'package:ego/models/ego_info_model.dart';
import 'package:ego/screens/diary/diary_view_screen.dart';
import 'package:ego/screens/ego_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder:
          (context, child) =>
          MaterialApp(
            title: 'EGO Edit Test',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Sample(),
          ),
    );
  }
}

class Sample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) {

                  return DiaryViewScreen();
                },
              ),
            );
          },
          child: const Text('일기 작성'),
        ),
      ),
    );
  }
}
