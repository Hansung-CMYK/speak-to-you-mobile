import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHistoryTest extends StatelessWidget {
  const HomeHistoryTest({super.key});

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
            routes: {'main': (context) => HomeHistoryScreen()},
          ),
    );
  }
}

// 에고 생성 - 에고 생성 스플래쉬
class HomeHistoryScreen extends ConsumerStatefulWidget {
  const HomeHistoryScreen({super.key});

  @override
  HomeHistoryScreenState createState() => HomeHistoryScreenState();
}

class HomeHistoryScreenState extends ConsumerState<HomeHistoryScreen>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  /// _tabCntroller 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// _tabCntroller 제거
  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: '대화기록'),
      body: Container(
        color: AppColors.gray200,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                _buildChatBubble(
                  '오늘은 어떤일이 있었어?',
                  AppColors.gray100,
                  Alignment.centerLeft,
                  '오전 9:20',
                  width: 178.w,
                  bubbleType: BubbleType.bottomLeftRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                  '블라블라 오늘도 블라블트라',
                  AppColors.royalBlue,
                  Alignment.centerRight,
                  textColor: Colors.white,
                  '오전 9:20',
                  width: 199.w,
                  bubbleType: BubbleType.bottomRightRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '오늘은 어떤일이 있었어?',
                    AppColors.gray100,
                    Alignment.centerLeft,
                    '오전 9:20',
                    width: 178.w,
                    bubbleType: BubbleType.bottomLeftRounded
                ),
                SizedBox(height: 4.h),
                _buildChatBubble(
                    '오늘은 어떤일이 있었어?',
                    AppColors.gray100,
                    Alignment.centerLeft,
                    '오전 9:20',
                    width: 178.w,
                    bubbleType: BubbleType.topLeftBottomLeftRounded
                ),
                SizedBox(height: 4.h),
                _buildChatBubble(
                    '오늘은 어떤일이 있었어?',
                    AppColors.gray100,
                    Alignment.centerLeft,
                    '오전 9:20',
                    width: 178.w,
                    bubbleType: BubbleType.topLeftRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '아 배고파 오늘 뭐 먹지',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: Colors.white,
                    '오전 9:20',
                    width: 163.w,
                    bubbleType: BubbleType.bottomRightRounded
                ),
                SizedBox(height: 4.h),
                _buildChatBubble(
                    '너는?',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: Colors.white,
                    '오전 9:20',
                    width: 60.w,
                    bubbleType: BubbleType.topRightBottomRightRounded
                ),
                SizedBox(height: 4.h),
                _buildChatBubble(
                    '블라블라 오늘도 블라블티나',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: Colors.white,
                    '오전 9:20',
                    width: 199.w,
                    bubbleType: BubbleType.topRightRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '말풍선 안에 텍스트 최대 가로 길이\n229px 입니다.',
                    AppColors.gray100,
                    Alignment.centerLeft,
                    '오전 9:20',
                    width: 253.w,
                    height: 64.h,
                    bubbleType: BubbleType.bottomLeftRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '너는?',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: Colors.white,
                    '오전 9:20',
                    width: 60.w,
                    bubbleType: BubbleType.bottomRightRounded
                ),
                SizedBox(height: 4.h),
                _buildChatBubble(
                    '말풍선 안에 텍스트 최대 가로 길이\n229px 입니다.',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: Colors.white,
                    '오전 9:20',
                    width: 253.w,
                    height: 64.h,
                    bubbleType: BubbleType.topRightRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '오늘은 어떤일이 있었어?',
                    AppColors.gray100,
                    Alignment.centerLeft,
                    '오전 9:20',
                    width: 178.w,
                    bubbleType: BubbleType.topLeftRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '아래쪽이 최신순인가?',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: Colors.white,
                    '오전 9:20',
                    width: 161.w,
                    bubbleType: BubbleType.bottomRightRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '위쪽이 최신순인가?',
                    AppColors.gray100,
                    Alignment.centerLeft,
                    '오전 9:20',
                    width: 147.w,
                    bubbleType: BubbleType.topLeftRounded
                ),
                SizedBox(height: 12.h),
                _buildChatBubble(
                    '블라블라 오늘도 블라블티나',
                    AppColors.royalBlue,
                    Alignment.centerRight,
                    textColor: AppColors.white,
                    '오전 9:20',
                    width: 199.w,
                    bubbleType: BubbleType.topRightRounded
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(
    String text,
    Color bgColor,
    Alignment alignment,
    String time, {
    Color textColor = AppColors.black,
    double height = 40.0,
    double width = 229.0,
    BubbleType bubbleType = BubbleType.fullRounded,
  }) {
    return Align(
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (alignment == Alignment.centerRight) _buildTimeText(time),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: ShapeDecoration(
              color: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: _getBubbleRadius(bubbleType),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 1.5.h,
                letterSpacing: -0.8.sp,
              ),
            ),
          ),
          if (alignment == Alignment.centerLeft) _buildTimeText(time),
        ],
      ),
    );
  }

  Widget _buildTimeText(String time) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Text(
        time,
        style: TextStyle(
          color: AppColors.gray600,
          fontSize: 12.sp,
          letterSpacing: -0.6.sp,
        ),
      ),
    );
  }

  BorderRadius _getBubbleRadius(BubbleType type) {
    switch (type) {
      case BubbleType.bottomRightRounded:
        return BorderRadius.only(
          bottomRight: Radius.circular(4.r),
          bottomLeft: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        );
      case BubbleType.bottomLeftRounded:
        return BorderRadius.only(
          bottomLeft: Radius.circular(4.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        );
      case BubbleType.topRightBottomRightRounded:
        return BorderRadius.only(
          topRight: Radius.circular(4.r),
          bottomRight: Radius.circular(4.r),
          bottomLeft: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        );
      case BubbleType.topLeftBottomLeftRounded:
        return BorderRadius.only(
          topLeft: Radius.circular(4.r),
          bottomLeft: Radius.circular(4.r),
          bottomRight: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        );
      case BubbleType.topLeftRounded:
        return BorderRadius.only(
          topLeft: Radius.circular(4.r),
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        );
      case BubbleType.topRightRounded:
        return BorderRadius.only(
          topRight: Radius.circular(4.r),
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        );
      default:
        return BorderRadius.circular(20.r);
    }
  }
}

enum BubbleType {
  fullRounded,
  bottomRightRounded,
  bottomLeftRounded,
  topRightBottomRightRounded,
  topLeftBottomLeftRounded,
  topLeftRounded,
  topRightRounded,
}
