import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 간단한 알림창(다이얼로그)을 보여주는 함수.
///
/// [context] : 빌드 컨텍스트
/// [title] : 다이얼로그 제목
/// [content] : 다이얼로그 내용
/// [titleColor] : 제목 텍스트 컬러
/// [contentColor] : 내용 텍스트 컬러
/// [buttonBackgroundColor] : 버튼 배경 컬러
/// [buttonForegroundColor] : 버튼 텍스트 컬러
/// [buttonOverlayColor] : 버튼 누를 때 효과 컬러(리플 등)
/// [buttonText] : 버튼에 표시될 텍스트 (기본값: '닫기')
Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  DialogType? dialogType,
  String? content,
  Color titleColor = AppColors.blueGray900,
  Color contentColor = AppColors.blueGray500,
  Color buttonBackgroundColor = AppColors.primary,
  Color buttonForegroundColor = AppColors.white,
  Color buttonOverlayColor = AppColors.white,
  String buttonText = '닫기',
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dialogType != null) ...[
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    dialogType.asset,
                    width: 48.w,
                    height: 48.h,
                  ),
                ),
                SizedBox(height: 12.h),
              ],
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
              if (content != null) ...[
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    content,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: contentColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: buttonForegroundColor,
                          backgroundColor: buttonBackgroundColor,
                          overlayColor: buttonOverlayColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
