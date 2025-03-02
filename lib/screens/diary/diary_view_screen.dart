import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ego/theme/color.dart';

// 조건 일기 주제, 내용, 감정

class DiaryViewScreen extends StatelessWidget {
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // API 요청 시뮬레이션
    return "API에서 받은 데이터";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '일기보기',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icon/back_arrow.svg',
            width: 24.w,
            height: 24.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding( // edit(전체수정), share(전체공유) 버튼
              padding: EdgeInsets.only(bottom: 20.h, right: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: SvgPicture.asset(
                      'assets/icon/share_icon.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: SvgPicture.asset(
                      'assets/icon/edit_icon.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                ],
              ),
            ),
            // TodayEmotionContainer();
          ],
        ),
      ),
    );
  }
}

/// 감정은 최대 3개 최소 1개로 전달 받음

Widget TodayEmotionContainer(List<String> emotions){
  return Container(
    width: 353,
    height: 38,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(1.00, 0.00),
        end: Alignment(-1, 0),
        colors: [Color(0xFFFEAC5E), Color(0xFFE6968D), Color(0xFFC779D0), Color(0xFF5865F2)],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '오늘의 감정',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                  letterSpacing: -0.80,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Expanded(
                      child: SizedBox(
                        child: Text(
                          '기쁨, 행복',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                            letterSpacing: -0.80,
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
      ],
    ),
  );
}
