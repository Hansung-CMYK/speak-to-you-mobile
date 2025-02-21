import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/color.dart';

/// '로그인'과 '회원가입'에서 이용할 버튼을 모듈화 한 클래스이다.
class CustomButton1 extends StatefulWidget {
  /// [text] 버튼 중앙에 나타날 텍스트
  final String text;
  /// [confirmMethod] 버튼 클릭 시 이루어질 동작
  final Function? confirmMethod;
  /// [height] 버튼의 높이
  final double? height;

  /// [text] 버튼 중앙에 나타날 텍스트
  /// [confirmMethod] 버튼 클릭 시 이루어질 동작. null 주입 시, 버튼은 비활성화 된다.
  /// [height] 버튼의 높이 (default: 56.h)
  const CustomButton1({required this.text, this.confirmMethod, this.height});

  @override
  _CustomButton1State createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          widget.confirmMethod != null // confirmMethod 가 null로 반환되면 Disable(비활성화) 상태이다.
              ? () => widget.confirmMethod!() // 버튼 활성화
              : null, // 버튼 비활성화
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary, // 활성화 상태일 때, 배경 색상
        foregroundColor: AppColors.white, // 비활성화 상태일 때, 텍스트 색상
        disabledBackgroundColor: AppColors.gray300, // 비활성화 상태일 때, 배경 색상
        disabledForegroundColor: AppColors.white, // 비활성화 상태일 때, 텍스트 색상
        shape: RoundedRectangleBorder( // 텍스트 버튼 형태 설정
          borderRadius: BorderRadius.circular(8.r), // 모서리 굴곡 8.0
        ),
        fixedSize: Size(
          double.maxFinite, // 너비 화면 최대 길이로 지정
          widget.height == null ? 56.h : widget.height!
        ), // TODO: 높이가 HardCoding 되어있음.
      ),
      child: Text(
        widget.text, // 사용자가 설정한 텍스트 설정
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}