import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ego/theme/color.dart';

/// 감정을 보여주는 그라데이션 Container
/// 감정은 최소 1개 최대 3개로 전달 받음
/// emotions는 문자열로 전달 받습니다. "활발함, 친절함"
Widget TodayEmotionContainer(String emotions) {
  return Container(
    color: AppColors.white,
    child: Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 12.h, left: 20.w, right: 20.w),
      alignment: Alignment.center,
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        gradient: LinearGradient(
          begin: Alignment(1.00, 0.00),
          end: Alignment(-1, 0),
          colors: [
            AppColors.vividOrange,
            AppColors.softCoralPink,
            AppColors.amethystPurple,
            AppColors.accent,
          ],
        ),
      ),
      child: Row(
        children: [
          Text(
            '오늘의 감정',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              emotions,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
