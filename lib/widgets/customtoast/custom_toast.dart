import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ego/theme/color.dart';

class CustomToast {
  final String toastMsg;
  final Color backgroundColor;
  final Color fontColor;
  final String iconPath;
  late FToast fToast;

  CustomToast({
    required this.toastMsg,
    this.backgroundColor = AppColors.accent,
    this.fontColor = AppColors.white,
    this.iconPath = "",
  });

  // Toast 틀을 의미합니다.
  // 사용자가 정의한 배경 색상, 글자색을 적용합니다.
  Widget get customedToast => Container(
    width: 152.w,
    height: 37.h,
    // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (iconPath.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: SvgPicture.asset(iconPath, width: 20.w, height: 20.h),
          ),
        ],
        Text(
          toastMsg,
          style: TextStyle(
            color: fontColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  void init(FToast fToast) {
    this.fToast = fToast;
  }

  void showBottomToast() {
    fToast.showToast(
      child: customedToast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void showTopToast() {
    fToast.showToast(
      child: customedToast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }
}
