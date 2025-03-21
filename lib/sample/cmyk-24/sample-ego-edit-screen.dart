import 'package:ego/models/ego_info_model.dart';
import 'package:ego/screens/ego_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: 'EGO Edit Test',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: SampleHomeScreen(),
          ),
    );
  }
}

class SampleHomeScreen extends StatelessWidget {
  EgoInfoModel egoInfoModel = EgoInfoModel(
    id: '1',
    egoIcon: '',
    egoName: 'Power',
    egoBirth: '2002/05/03',
    egoPersonality: '활발, 착함',
    egoMBTI: 'ENFJ',
    egoSelfIntro:
        "나는 파워! 피의 악마다! 인간 따윈 우습지만, 냥이는 소중해! 머리도 좋고 싸움도 최고지! 덴지, 나를 왕처럼 떠받들라!",
  );

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
                    (context) => EgoEditScreen(myEgoInfoModel: egoInfoModel),
              ),
            );
          },
          child: const Text('EGO 수정 화면으로 이동'),
        ),
      ),
    );
  }
}
