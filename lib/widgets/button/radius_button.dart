import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/color.dart';

/// '로그인'과 '회원가입'에서 이용할 버튼을 모듈화 한 클래스이다.
class RadiusButton extends StatefulWidget {
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Function? confirmMethod;
  final String? logoPath;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final TextStyle? textStyle;

  /// [text] 버튼 중앙에 나타날 텍스트 <br>
  /// [foregroundColor] 활성화 상태일 때, 텍스트 색상 <br>
  /// [backgroundColor] 활성화 상태일 때, 배경 색상 <br>
  /// [disabledForegroundColor] 비활성화 상태일 때, 텍스트 색상 **Default** AppColors.white <br>
  /// [disabledBackgroundColor] 비활성화 상태일 때, 배경 색상 **Default** AppColors.gray300 <br>
  /// [confirmMethod] 버튼 클릭 시 이루어질 동작 <br>
  /// [logoPath] 로고 Asset이 위치한 경로 <br>
  /// [radius] 텍스트 필드의 모서리 굴곡을 조정하기 위한 객체이다. (default: 8.r)
  /// [height] 버튼의 높이 **Default** 56.h  <br>
  /// [borderColor] 테두리 색상 (두께는 1.w 고정이다.) <br>
  /// [textStyle] 텍스트의 속성을 조정한다. ex) fontSize, fontWeight **Default** fontSize: 18.sp, fontWeight: w400 <br>
  const RadiusButton({
    required this.text,
    required this.foregroundColor,
    required this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    required this.confirmMethod,
    this.logoPath,
    this.radius,
    this.height,
    this.borderColor,
    this.textStyle,
  });

  @override
  _RadiusButtonState createState() => _RadiusButtonState();
}

class _RadiusButtonState extends State<RadiusButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
      widget.confirmMethod != null // confirmMethod 가 null로 반환되면 Disable(비활성화) 상태이다.
          ? () => widget.confirmMethod!() // 버튼 활성화
          : null, // 버튼 비활성화
      style: TextButton.styleFrom(
        foregroundColor: widget.foregroundColor, // 비활성화 상태일 때, 텍스트 색상
        backgroundColor: widget.backgroundColor, // 활성화 상태일 때, 배경 색상
        disabledForegroundColor: widget.disabledBackgroundColor ?? AppColors.white, // 비활성화 상태일 때, 텍스트 색상
        disabledBackgroundColor: widget.disabledBackgroundColor ?? AppColors.gray300, // 비활성화 상태일 때, 배경 색상
        shape: RoundedRectangleBorder( // 텍스트 버튼 형태 설정
          borderRadius: BorderRadius.circular(widget.radius ?? 8.r), // 모서리 굴곡 8.0
          side: BorderSide(
            color: widget.borderColor ?? AppColors.transparent,
            width: 1.w,
          ),
        ),
        fixedSize: Size(
            double.maxFinite, // 너비 화면 최대 길이로 지정
            widget.height ?? 56.h
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            widget.logoPath != null
            ? SvgPicture.asset(
              widget.logoPath!,
              width: 16.w,
              height: 16.h,
            ) : SizedBox(),
            Expanded(
              child: Text(
                widget.text,
                style: widget.textStyle ?? TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600
                  ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}