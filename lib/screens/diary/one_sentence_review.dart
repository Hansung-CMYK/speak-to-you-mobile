import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ego/theme/color.dart';

// 오늘의 한 줄 요약 내용 부분
Widget OneSentenceReview(String sentence) {
  return Container(
    padding: EdgeInsets.only(bottom: 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "오늘의 한 줄 요약",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 100.h,
          child: SingleChildScrollView(
            child: Text(
              '"$sentence"',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    ),
  );
}
