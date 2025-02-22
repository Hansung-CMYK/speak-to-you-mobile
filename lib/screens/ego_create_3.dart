import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 에고 생성 - 이름 작성
class EgoProfileTest3 extends StatelessWidget {
  const EgoProfileTest3({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: '에고 생성 - 이름 작성',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: 'main',
            routes: {'main': (context) => EgoScreen3()},
          ),
    );
  }
}

class EgoScreen3 extends StatelessWidget {
  const EgoScreen3({super.key});

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
                        '나의 EGO 이름을 지어주세요!',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                top: 238.h,
                child: SizedBox(
                  width: 353.w, // 명확한 너비 지정
                  child: TextField(
                    maxLength: 10,
                    style: TextStyle(
                      color: AppColors.gray300, // 텍스트 색상
                      fontSize: 20.sp, // 폰트 크기, ScreenUtil을 사용하여 화면 크기 조정
                      fontFamily: 'Roboto', // 폰트
                      fontWeight: FontWeight.w500, // 폰트 두께
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 18.h,
                        horizontal: 20.w,
                      ),
                      // 패딩 조정
                      filled: true,
                      // 배경 색상 추가 여부
                      fillColor: AppColors.gray100,
                      // 배경 색상
                      hintText: '최대 10자',
                      // 힌트 텍스트
                      hintStyle: TextStyle(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        // 힌트 텍스트 색상
                        fontSize: 20.sp,
                        // 힌트 텍스트 폰트 크기
                        fontFamily: 'Roboto', // 폰트
                      ),
                      labelStyle: TextStyle(
                        color: AppColors.gray800, // 작성한 텍스트 색상
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black),
                        // 테두리 색상 (선택시)
                        borderRadius: BorderRadius.circular(8.r), // 모서리 둥글기
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray200),
                        // 기본 테두리 색상
                        borderRadius: BorderRadius.circular(8.r), // 모서리 둥글기
                      ),
                      border: InputBorder.none,
                      // 기본 테두리 제거
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: AppColors.gray400, // 아이콘 색상
                          size: 20.w, // 아이콘 크기
                        ),
                        onPressed: () {}, // 텍스트 필드의 내용을 지우는 버튼 (기능은 추가 필요)
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                top: 312.h,
                child: SizedBox(
                  width: 353.w,
                  child: SizedBox(
                    width: 353.w,
                    child: Text(
                      '이미 사용중인 닉네임 입니다.',
                      style: TextStyle(
                        color: AppColors.errorBase,
                        fontSize: 14,
                        fontFamily: 'Roboto-Regular',
                        fontWeight: FontWeight.w500,
                        height: 1.45.h,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: SafeArea(
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
    );
  }
}
