import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 에고 생성 - EGO 소개글
class EgoProfileTest5 extends StatelessWidget {
  const EgoProfileTest5({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: '에고 생성 - EGO 소개글',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: 'main',
            routes: {'main': (context) => EgoScreen5()},
          ),
    );
  }
}

class EgoScreen5 extends StatelessWidget {
  const EgoScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO 상태 관리
    final buttonBottomOffset = false ? 12.h : 40.h;
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
                          height: 1.50.sp,
                        ),
                      ),
                      Text(
                        '매력적인 나의 EGO의 모습을 담아보세요.',
                        style: TextStyle(
                          color: AppColors.gray600,
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 1.50.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                top: 461.h,
                child: SizedBox(
                  width: 353.w,
                  child: SizedBox(
                    width: 353.w,
                    child: Text(
                      '0/100',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.gray600,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.45.h,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                top: 293.h,
                child: Container(
                  width: 353.w,
                  height: 160.h,
                  padding: const EdgeInsets.all(20),
                  decoration: ShapeDecoration(
                    color: AppColors.gray100,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: AppColors.gray200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: Text(
                                '소개 입력',
                                style: TextStyle(
                                  color:
                                      AppTheme
                                          .lightTheme
                                          .colorScheme
                                          .onSurfaceVariant,
                                  fontSize: 18.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
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
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: Text(
                            '나의 EGO 를 소개해주세요!',
                            style: TextStyle(
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              fontSize: 24.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                              height: 1.50.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            '간단한 인사말도 좋아요.',
                            style: TextStyle(
                              color: AppColors.gray600,
                              fontSize: 14.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 1.50.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16.w,
                top: 44.h,
                child: Container(
                  width: 361.w,
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 4,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Positioned(
          left: 0.w,
          top: 744.h,
          child: SafeArea(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, buttonBottomOffset),
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color:
                            true // TODO 상태 관리
                                ? AppColors.deepPrimary
                                : AppColors.gray300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 56.h,
                      child: TextButton(
                        onPressed:
                            true // TODO 상태 관리
                                ? () {
                                  // TODO 다음 페이지
                                }
                                : null,
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          foregroundColor: WidgetStateProperty.all(
                            AppColors.white,
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          overlayColor: WidgetStateProperty.all(
                            AppColors.white.withValues(alpha: 0.1),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '다음',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
