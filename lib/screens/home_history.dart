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
        child: Padding(
          padding: EdgeInsets.only(right: 9.w),
          child: RawScrollbar(
            thumbVisibility: true,
            thickness: 3,
            thumbColor: AppColors.gray700,
            radius: Radius.circular(10.r),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // SingleChildScrollView와 충돌 방지
                  shrinkWrap: true,
                  // 부모 위젯 크기에 맞춤
                  itemCount: chatData.length,
                  // 데이터 리스트 개수
                  itemBuilder: (context, index) {
                    final chat = chatData[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildChatBubble(
                        chat.message,
                        chat.color,
                        chat.alignment,
                        chat.height,
                        chat.width,
                        chat.time,
                        textColor:
                            chat.textColor != null
                                ? chat.textColor!
                                : AppColors.black,
                        bubbleType: chat.bubbleType,
                      ),
                    );
                  },
                ),
              ),
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
    double height,
    double width,
    String time, {
    Color textColor = AppColors.black,
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

class ChatMessage {
  final String message;
  final Color color;
  final Alignment alignment;
  final double height;
  final double width;
  final String time;
  final Color? textColor;
  final BubbleType bubbleType;

  ChatMessage({
    required this.message,
    required this.color,
    required this.alignment,
    required this.height,
    required this.width,
    required this.time,
    this.textColor,
    required this.bubbleType,
  });
}

List<ChatMessage> chatData = [
  ChatMessage(
    message: '오늘은 어떤일이 있었어?',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 40.h,
    width: 178.w,
    time: '오전 9:20',
    bubbleType: BubbleType.bottomLeftRounded,
  ),
  ChatMessage(
    message: '블라블라 오늘도 블라블트라',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 199.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.bottomRightRounded,
  ),
  ChatMessage(
    message: '오늘은 어떤일이 있었어?',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 40.h,
    width: 178.w,
    time: '오전 9:20',
    bubbleType: BubbleType.bottomLeftRounded,
  ),
  ChatMessage(
    message: '오늘은 어떤일이 있었어?',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 40.h,
    width: 178.w,
    time: '오전 9:20',
    bubbleType: BubbleType.topLeftBottomLeftRounded,
  ),
  ChatMessage(
    message: '오늘은 어떤일이 있었어?',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 40.h,
    width: 178.w,
    time: '오전 9:20',
    bubbleType: BubbleType.topLeftRounded,
  ),
  ChatMessage(
    message: '아 배고파 오늘 뭐 먹지',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 163.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.bottomRightRounded,
  ),
  ChatMessage(
    message: '너는?',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 60.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.topRightBottomRightRounded,
  ),
  ChatMessage(
    message: '블라블라 오늘도 블라블티나',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 199.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.topRightRounded,
  ),
  ChatMessage(
    message: '말풍선 안에 텍스트 최대 가로 길이\n229px 입니다.',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 64.h,
    width: 253.w,
    time: '오전 9:20',
    bubbleType: BubbleType.bottomLeftRounded,
  ),
  ChatMessage(
    message: '너는?',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 60.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.bottomRightRounded,
  ),
  ChatMessage(
    message: '말풍선 안에 텍스트 최대 가로 길이\n229px 입니다.',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 64.h,
    width: 253.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.topRightRounded,
  ),
  ChatMessage(
    message: '오늘은 어떤일이 있었어?',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 40.h,
    width: 178.w,
    time: '오전 9:20',
    bubbleType: BubbleType.topLeftRounded,
  ),
  ChatMessage(
    message: '아래쪽이 최신순인가?',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 161.w,
    time: '오전 9:20',
    textColor: Colors.white,
    bubbleType: BubbleType.bottomRightRounded,
  ),
  ChatMessage(
    message: '위쪽이 최신순인가?',
    color: AppColors.gray100,
    alignment: Alignment.centerLeft,
    height: 40.h,
    width: 147.w,
    time: '오전 9:20',
    bubbleType: BubbleType.topLeftRounded,
  ),
  ChatMessage(
    message: '블라블라 오늘도 블라블티나',
    color: AppColors.royalBlue,
    alignment: Alignment.centerRight,
    height: 40.h,
    width: 199.w,
    time: '오전 9:20',
    bubbleType: BubbleType.topRightRounded,
  ),
];
