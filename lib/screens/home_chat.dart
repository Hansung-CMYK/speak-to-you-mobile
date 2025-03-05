import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/appbar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeChatTest extends StatelessWidget {
  const HomeChatTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: '홈(대화하기) - 대화내역',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: 'main',
            routes: {'main': (context) => HomeChatScreen()},
          ),
    );
  }
}

// 에고 생성 - 에고 생성 스플래쉬
class HomeChatScreen extends ConsumerStatefulWidget {
  const HomeChatScreen({super.key});

  @override
  HomeChatScreenState createState() => HomeChatScreenState();
}

class HomeChatScreenState extends ConsumerState<HomeChatScreen>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;

  /// _tabCntroller 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// _tabCntroller 제거
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(_tabController),
      body: Container(
        padding: EdgeInsets.only(bottom: 40),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 20.w,
              top: 26.h,
              child: Container(
                width: 353.w,
                height: 38.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [
                      AppColors.vividOrange,
                      AppColors.softCoralPink,
                      AppColors.amethystPurple,
                      AppColors.royalBlue,
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '대화 주제',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.5.h,
                        letterSpacing: -0.8.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 1.w,
                      height: 16.h,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '미정',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.5.h,
                        letterSpacing: -0.8.sp,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: SvgPicture.asset(
                        'assets/icon/small_right.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 21.w,
              top: 72.h,
              child: Container(
                width: 353.w,
                height: 63.h,
                padding: EdgeInsets.only(
                  top: 8.h,
                  left: 8.w,
                  right: 8.w,
                  bottom: 8.h,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.w, color: AppColors.gray200),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                              child: Text(
                                '오늘의 EGO',
                                style: TextStyle(
                                  color: Color(0xFF72787F),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                              child: Text(
                                '보글보글 캡라면',
                                style: TextStyle(
                                  color: AppColors.gray900,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 45.h,
                      height: 45.h,
                      decoration: BoxDecoration(),
                      child: SvgPicture.asset(
                        'assets/icon/comment_smile.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 280.w,
              top: 143.h,
              child: Container(
                width: 91.w,
                height: 32.h,
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 83.w,
                      child: Text(
                        '대화기록 보기',
                        style: TextStyle(
                          color: AppColors.gray600,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.5.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              top: 256.h,
              child: Container(
                width: 191.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: ShapeDecoration(
                  color: AppColors.gray100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '나는 아침에 운동을 했어!',
                      style: TextStyle(
                        color: AppColors.gray900,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.5.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 311.w,
              top: 304.h,
              child: Container(
                width: 62.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: ShapeDecoration(
                  color: AppColors.royalBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(4.r),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '너는?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.5.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 33.w,
              top: 348.h,
              child: Container(
                width: 341.w,
                height: 92.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: ShapeDecoration(
                  color: AppColors.royalBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(4.r),
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '생각보다 괜찮은 하루였어! 아침에 조금 일찍\n나왔더니 지하철도 널널하고 버스에서도 앉아서\n출근했더니 덜 피곤한 하루였어',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.5.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 21.w,
              top: 448.h,
              child: Container(
                width: 191.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: ShapeDecoration(
                  color: AppColors.gray100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 24.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '오늘은 어떤일이 있었어?',
                        style: TextStyle(
                          color: AppColors.gray900,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.5.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              top: 500.h,
              child: SizedBox(
                width: 353.w,
                height: 220.h,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icon/ego_icon_big.svg',
                      fit: BoxFit.contain,
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text, Color bgColor, Alignment alignment,
      {Color textColor = Colors.black, double height = 40.0}) {
    return Align(
      alignment: alignment,
      child: Container(
        width: text.length * 10.w > 341.w ? 341.w : text.length * 10.w,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(alignment == Alignment.centerRight ? 20.r : 4.r),
              topRight: Radius.circular(alignment == Alignment.centerLeft ? 20.r : 4.r),
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 1.5.h,
          ),
        ),
      ),
    );
  }
}


