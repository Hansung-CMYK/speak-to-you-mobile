import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 다이얼로그 타입을 관리하는 enum
/// - info: 정보성 다이얼로그
/// - success: 성공 메시지 다이얼로그
enum DialogType { info, success }

/// DialogType에 따라 다른 SVG 에셋 파일 경로를 반환하는 Extension
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

/// 확인(Confirm) 다이얼로그를 표시하는 함수.
///
/// [context] : 빌드 컨텍스트
/// [title] : 다이얼로그 제목
/// [content] : 다이얼로그 내용
/// [dialogType] : 다이얼로그 타입 (info, success) 아이콘 표시
/// [stack] : 버튼을 세로로 쌓아서 표시할지 여부 (false라면 버튼을 가로로 나란히 배치)
/// [titleColor] : 제목 텍스트 색상
/// [contentColor] : 내용 텍스트 색상
/// [cancelBackgroundColor], [cancelForegroundColor], [cancelOverlayColor] : 취소 버튼 색상 관련
/// [cancelText] : 취소 버튼에 표시될 텍스트 (기본값: '닫기')
/// [confirmBackgroundColor], [confirmForegroundColor], [confirmOverlayColor] : 확인 버튼 색상 관련
/// [confirmText] : 확인 버튼에 표시될 텍스트 (기본값: '확인')
///
/// 반환값: [showDialog] 의 반환값 (true: 확인 눌림, false: 닫기 눌림, null: 다이얼로그 외부 터치 등)
Future<bool?> showConfirmDialog({
  required BuildContext context,
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
  String confirmText = '확인',
}) async {
  /// 버튼 위젯을 빌드하기 위한 헬퍼 함수
  ///
  /// [text] : 버튼 텍스트
  /// [backgroundColor] : 버튼 배경색
  /// [foregroundColor] : 버튼 텍스트(전경) 색
  /// [overlayColor] : 버튼을 누를 때 리플/오버레이 색
  /// [onPressed] : 버튼이 눌렸을 때의 콜백 함수
  Widget buildButton({
    required String text,
    required Color backgroundColor,
    required Color foregroundColor,
    required Color overlayColor,
    required VoidCallback onPressed,
  }) {
    // stack == true 인 경우 버튼 전체를 가로폭에 맞춤
    // stack == false 인 경우 가로로 확장(Expanded)하여 Row에서 사용
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
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
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
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ),
          );
  }

  /// 버튼 그룹을 빌드하기 위한 헬퍼 함수
  /// stack == true 인 경우, 버튼을 세로로 쌓아 표시
  /// stack == false 인 경우, 가로로 나란히 배치
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

  // showDialog를 통해 다이얼로그 표시
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
              // 만약 dialogType이 null이 아니라면 (info/success)가 존재한다면 아이콘 표시
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
