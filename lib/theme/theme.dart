import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,

      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white, // onPrimary 는 primary 배경 위 텍스트 색상

        secondary: AppColors.accent,
        onSecondary: AppColors.white,

        surface: AppColors.white, // 배경색
        onSurface: AppColors.gray900, // 전경색
        onSurfaceVariant: AppColors.gray300, // 비활성 버튼 배경색

        error: AppColors.errorBase,
        onError: AppColors.white,
      ),

      scaffoldBackgroundColor: AppColors.white,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.gray900,
        elevation: 0,
      ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: AppColors.gray900,
          fontSize: 16,
        ),
      ),

      iconTheme: const IconThemeData(
        color: AppColors.gray700,
      ),

      // etc
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.accent,
        onSecondary: AppColors.white,
        surface: AppColors.gray800,
        onSurface: AppColors.gray100,
        error: AppColors.errorBase,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.gray900,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.gray900,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: AppColors.gray100,
          fontSize: 16,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.gray400,
      ),
    );
  }
}
