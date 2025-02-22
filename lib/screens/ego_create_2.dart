import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 에고 생성 - 프로필 설정
class EgoProfileTest2 extends StatelessWidget {
  const EgoProfileTest2({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) =>
          MaterialApp(
            title: '에고 생성 - 프로필 설정',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: 'main',
            routes: {'main': (context) => EgoScreen2()},
          ),
    );
  }
}

class EgoScreen2 extends StatelessWidget {
  const EgoScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 20.w,
                top: 104.h,
                child: Image.asset(
                  'assets/image/ego_2.png', // 이미지 경로
                  width: 48.w, // 원하는 크기로 조정
                  height: 68.h,
                ),
              ),
              Positioned(
                left: 20.w,
                top: 184.h,
                child: SizedBox(
                  height: 69.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '프로필 이미지를 선택해주세요!',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          height: 1.50.h,
                        ),
                      ),
                      Text(
                        '매력적인 나의 EGO의 모습을 담아보세요.',
                        style: TextStyle(
                          color: Color(0xFF72787F),
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 1.50.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 97.w,
                top: 293.h,
                child: SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/image/ego_3.png', // 이미지 경로
                        width: 200.w, // 원하는 크기로 조정
                        height: 200.h,
                      ),
                      Positioned(
                        left: 144.w,
                        top: 144.h,
                        child: Image.asset(
                          'assets/image/camera.png', // 이미지 경로
                          width: 48.w, // 원하는 크기로 조정
                          height: 48.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0.w,
                top: 744.h,
                child: Container(
                  height: 108.h,
                  padding: EdgeInsets.only(
                    top: 12.h,
                    left: 20.w,
                    right: 20.w,
                    bottom: 40.h,
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 353.w,
                        height: 56.h,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: AppTheme.lightTheme.colorScheme.onPrimaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      '다음',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        height: 1.25.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
