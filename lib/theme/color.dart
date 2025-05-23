import 'package:flutter/material.dart';

/// Figma에 정의되지 않은 색상은 다음을 참고
///
/// https://v3.tailwindcss.com/docs/customizing-colors
///
/// ```
/// 1. 중복 선언 금지
/// 2. 연한 색에서 진한 색으로 선언
/// ```
///
class AppColors {
  static const Color primary = Color(0xFFFE8745);
  static const Color deepPrimary = Color(0xFFFF7410);
  static const Color accent = Color(0xFF5865F2);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color lightGray = Color(0xFFD9D9D9);
  static const Color gray100 = Color(0xFFF7F8F9);
  static const Color gray200 = Color(0xFFE8EBED);
  static const Color gray300 = Color(0xFFC9CDD2);
  static const Color gray400 = Color(0xFF9EA4AA);
  static const Color gray600 = Color(0xFF72787F);
  static const Color gray700 = Color(0xFF454C53);
  static const Color gray800 = Color(0xFF26282B);
  static const Color gray900 = Color(0xFF1E1E1E);

  static const Color splitterColor = Color(0xFFF7F8F9);
  static const Color shadowColor = Color(0x1F000000);
  static const Color darkCharcoal = Color(0xFF3B3A3A);

  static const Color blueGray500 = Color(0xFF777B84);
  static const Color blueGray900 = Color(0xFF090E18);

  static const Color successLight = Color(0xFF4ADE80);
  static const Color successBase = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF16A34A);
  static const Color activeCall = Color(0xFF4FE200);

  static const Color warningLight = Color(0xFFFDE047);
  static const Color warningBase = Color(0xFFFACC15);
  static const Color warningDark = Color(0xFFEAB308);

  static const Color errorLight = Color(0xFFFF7171);
  static const Color errorBase = Color(0xFFFF4747);
  static const Color errorDark = Color(0xFFDD3333);

  static const Color brighterRed = Color(0xFFFF3B30);
  // 기타 색상
  static const Color transparent = Colors.transparent;
  static const Color naverColor = Color(0xFF03C754);
  static const Color unfilterBtn = Color(0xFFB2B2B2);

  static const Color vividOrange = Color(0xFFFEAC5E);
  static const Color softCoralPink = Color(0xFFE6968D);
  static const Color strongOrange = Color(0xFFFF7410);
  static const Color amethystPurple = Color(0xFFC779D0);
  static const Color royalBlue = Color(0xFF5865F2);
  static const Color callColor = Color(0xFF14B16A);
  static const Color humanChatColor = Color(0xFFDDFFC3);

  static const Color red = Colors.red;
}
