import 'package:ego/theme/color.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ego_list_item.dart';

// Gradient가 있는 EGO 사진
Widget buildEgoListItemGradient(Uint8List? profileImageBytes, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment(1, 0),
              end: Alignment(-1, 0),
              colors: [
                AppColors.royalBlue,
                AppColors.amethystPurple,
                AppColors.softCoralPink,
                AppColors.vividOrange,
              ],
            ),
          ),
        ),
        Container(
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
        ),
        buildEgoListItem(profileImageBytes, onTap),
      ],
    ),
  );
}