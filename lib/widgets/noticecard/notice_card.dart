import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NoticeCard extends StatelessWidget {
  final String category;
  final String title;
  final DateTime date;

  const NoticeCard({super.key, required this.category, required this.title, required this.date});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 24.w,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  DateFormat('yyyy. MM. dd').format(date),
                  style: TextStyle(
                    color: AppColors.gray600, // TODO: 우리 설정에 `greyScale500`이 없음.
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            size: 20.w,
            Icons.keyboard_arrow_right_rounded,
            color: AppColors.gray400,
          ),
        ],
      ),
    );
  }
}