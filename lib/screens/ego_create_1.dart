
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 에고 생성 - 에고 생성 스플래쉬
class EgoProfileTest1 extends StatelessWidget {
  const EgoProfileTest1({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
        title: '에고 생성 - 에고 생성 스플래쉬',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: 'main',
        routes: {'main': (context) => EgoScreen1()},
      ),
    );
  }
}

class EgoScreen1 extends StatelessWidget {
  const EgoScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.only(
            top: 164.h,
            left: 20.w,
            right: 20.w,
            bottom: 211.h,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '나만의 EGO 프로필을\n작성해 볼까요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 28.67),
                Image.asset(
                  'assets/image/ego_1.png', // 이미지 경로
                  width: 219.w, // 원하는 크기로 조정
                  height: 333.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
