import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum DialogType { info, success }

extension DialogTypeExtension on DialogType {
  String get asset {
    switch (this) {
      case DialogType.info:
        return 'assets/icon/info.svg';
      case DialogType.success:
        return 'assets/icon/success.svg';
    }
  }
}

Future<bool?> showConfirmDialog(
    {required BuildContext context,
    required String title,
    required String content,
    DialogType? dialogType,
    bool stack = false,
    Color titleColor = AppColors.blueGray900,
    Color contentColor = AppColors.blueGray500,
    Color cancelBackgroundColor = AppColors.gray200,
    Color cancelForegroundColor = AppColors.gray600,
    Color cancelOverlayColor = AppColors.gray400,
    String cancelText = '닫기',
    Color confirmBackgroundColor = AppColors.primary,
    Color confirmForegroundColor = AppColors.white,
    Color confirmOverlayColor = AppColors.white,
    String confirmText = '확인'}) async {
  Widget buildButton({
    required String text,
    required Color backgroundColor,
    required Color foregroundColor,
    required Color overlayColor,
    required VoidCallback onPressed,
  }) {
    return stack
        ? SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                overlayColor: overlayColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  )),
            ),
          )
        : Expanded(
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                overlayColor: overlayColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  )),
            ),
          );
  }

  Widget buildButtonGroup() {
    return stack
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildButton(
                text: cancelText,
                backgroundColor: cancelBackgroundColor,
                foregroundColor: cancelForegroundColor,
                overlayColor: cancelOverlayColor,
                onPressed: () => Navigator.of(context).pop(false),
              ),
              SizedBox(height: 8.h),
              buildButton(
                text: confirmText,
                backgroundColor: confirmBackgroundColor,
                foregroundColor: confirmForegroundColor,
                overlayColor: confirmOverlayColor,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildButton(
                text: cancelText,
                backgroundColor: cancelBackgroundColor,
                foregroundColor: cancelForegroundColor,
                overlayColor: cancelOverlayColor,
                onPressed: () => Navigator.of(context).pop(false),
              ),
              SizedBox(width: 8.w),
              buildButton(
                text: confirmText,
                backgroundColor: confirmBackgroundColor,
                foregroundColor: confirmForegroundColor,
                overlayColor: confirmOverlayColor,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
  }

  return showDialog<bool>(
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
                child: buildButtonGroup(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
