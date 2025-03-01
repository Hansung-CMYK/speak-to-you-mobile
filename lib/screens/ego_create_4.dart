import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 에고 생성 - MBTI
class EgoProfileTest4 extends StatelessWidget {
  const EgoProfileTest4({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: '에고 생성 - MBTI',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: 'main',
            routes: {'main': (context) => EgoScreen4()},
          ),
    );
  }
}

class EgoScreen4 extends StatelessWidget {
  const EgoScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Container(
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
                          '지금의 MBTI가 어떻게 되나요?',
                          style: TextStyle(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontSize: 24.sp,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800,
                            height: 1.50.h,
                          ),
                        ),
                        Text(
                          'MBTI 유형을 토대로 잘맞는 EGO를 소개해 드릴게요!',
                          style: TextStyle(
                            color: AppColors.gray600,
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
                  left: 20.w,
                  top: 293.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.deepPrimary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'INTJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
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
                  top: 453.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ENTJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20.sp,
                  top: 356.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ISTJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
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
                  top: 516.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ESTJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 112.w,
                  top: 293.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'INTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 112.w,
                  top: 453.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ENTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 112.w,
                  top: 356.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ISFJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 112.w,
                  top: 516.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ESFJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 204.w,
                  top: 293.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'INFJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 204.w,
                  top: 453.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ENFJ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 204.w,
                  top: 356.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ISTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 204.w,
                  top: 516.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ESTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 296.w,
                  top: 293.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'INFP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 296.w,
                  top: 453.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ENFP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 296.w,
                  top: 356.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ISFP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 296.w,
                  top: 516.h,
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 9.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 57.w,
                          child: SizedBox(
                            width: 57.w,
                            child: Text(
                              'ESFP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.11.sp,
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
                  top: 428.h,
                  child: Container(
                    width: 353.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Positioned(
                  left: 16.w,
                  top: 44.h,
                  child: Container(
                    width: 361.w,
                    padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 24.w,
                          height: 24.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 4.h,
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
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.deepPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  '다음',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25.h,
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
      ),
    );
  }
}
