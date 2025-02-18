import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  Color titleColor = AppColors.black,
  Color contentColor = AppColors.gray700,
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
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: contentColor,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Align(
                  alignment: Alignment.center,
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: buttonForegroundColor,
                          backgroundColor: buttonBackgroundColor,
                          overlayColor: buttonOverlayColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(buttonText,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            )),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      );
    },
  );
}
