import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ego/theme/color.dart';

/// Custom된 Toast Msg를 띄우는 Class 입니다.
///
/// - [toastMsg] 표시할 메시지 (String)
/// - [backgroundColor] 배경 색상 (Color, 기본값: AppColors.accent)
/// - [fontColor] 글자 색상 (Color, 기본값: AppColors.white)
/// - [iconPath] 아이콘 경로 (String, 기본값: 빈 문자열)
/// - [durationSec] 띄워져 있는 시간 (int)
class CustomToast {
  final String toastMsg;
  final Color backgroundColor;
  final Color fontColor;
  final String iconPath;
  final int durationSec;

  late FToast fToast;

  CustomToast({
    required this.toastMsg,
    this.backgroundColor = AppColors.accent,
    this.fontColor = AppColors.white,
    this.iconPath = "",
    this.durationSec = 2,
  });

  // Toast 틀을 의미합니다.
  // 사용자가 정의한 배경 색상, 글자색을 적용합니다.
  // 전달된 icon경로가 있다면 Icon을 추가 합니다.
  Widget get customedToast => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
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

  // 화면의 하단에 보여지는 Toast Msg
  void showBottomToast() {
    fToast.showToast(
      child: customedToast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: durationSec),
    );
  }

  //화면의 상단에 보여지는 Toast Msg
  void showTopToast() {
    fToast.showToast(
      child: customedToast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: durationSec),
    );
  }

  // 키보드와 겹치지지 않도록 배치되는 Toast Msg
  void showKeyboardTopToast() {
    fToast.showToast(
      child: customedToast,
      toastDuration: Duration(seconds: durationSec),
      positionedToastBuilder: (context, child, gravity) {
        // Toast Msg와 키보드 사이에 15만큼의 여백이 생깁니다.
        double bottomPadding = MediaQuery.of(context).viewInsets.bottom + 15.h;

        return Positioned(
          bottom: bottomPadding,
          left: 0,
          right: 0,
          child: Center(child: child),
        );
      },
    );
  }

  // 화면 밑에서 부터 Bottom위치를 조정할 수 있는 Toast
  void showBottomPositionedToast({
    double bottom = 0.0,
  }) {
    fToast.showToast(
      child: customedToast,
      toastDuration: Duration(seconds: durationSec),
      positionedToastBuilder: (context, child, gravity) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: bottom,
          child: Center(child: child),
        );
      },
    );
  }
}
