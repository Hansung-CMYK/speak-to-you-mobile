import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/button/radius_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLoginScreen extends StatelessWidget {
  void emailClickMethod(BuildContext context) {
    Navigator.pushNamed(context, 'EmailLogin');
  }

  void naverClickMethod(BuildContext context) {
    Navigator.pushNamed(context, 'NaverLogin');
  }

  void googleClickMethod(BuildContext context) {
    Navigator.pushNamed(context, 'GoogleLogin');
  }

  void signUpClickMethod(BuildContext context) {
    Navigator.pushNamed(context, 'SignUp');
  }

  const MainLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: ""), // TODO: 임시 배치
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _slogan(),
            SizedBox(height: 55.h,),
            _title(),
            SizedBox(height: 50.h,),
            _buttons(context),
            SizedBox(height: 24.h,),
            _textLogo(context),
          ],
        ),
      )
    );
  }

  Widget _slogan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "나의 기록이 소통이 \n되는 이곳",
          style: TextStyle(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          "나와 딱맞는 EGO를",
          style: TextStyle(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( // TODO: 폰트 변경할 것
          "Speak To You",
          style: TextStyle(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "EGO",
              style: TextStyle(
                fontSize: 34.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        RadiusButton(
          logoPath: '',
          text: '이메일로 계속하기',
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          confirmMethod: () => emailClickMethod(context),
          height: 48.h,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            spacing: 12.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 1.h,
                  color: AppColors.gray300,
                ),
              ),
              Text(
                "또는",
                style: TextStyle(
                  color: AppColors.gray600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 1.h,
                  color: AppColors.gray300,
                ),
              ),
            ],
          ),
        ),
        RadiusButton(
          logoPath: 'assets/icon/NaverLogo.svg',
          text: '네이버로 계속하기',
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.naverColor,
          confirmMethod: () => naverClickMethod(context),
          height: 48.h,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp
          ),
        ),
        RadiusButton(
          logoPath: 'assets/icon/GoogleLogo.svg',
          text: 'Google로 계속하기',
          foregroundColor: AppColors.gray900,
          backgroundColor: AppColors.white,
          confirmMethod: () => googleClickMethod(context),
          borderColor: AppColors.gray300,
          height: 48.h,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp
          ),
        ),
      ],
    );
  }

  Widget _textLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.w,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icon/TextLogo-E.svg',
              width: 8.w,
              height: 12.h,
            ),
            SvgPicture.asset(
              'assets/icon/TextLogo-G.svg',
              width: 10.w,
              height: 12.h,
            ),
            SvgPicture.asset(
              'assets/icon/TextLogo-O.svg',
              width: 11.56.w,
              height: 12.h,
            ),
          ],
        ),
        TextButton(
          onPressed: () => signUpClickMethod(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: AppColors.transparent,
          ),
          child: Text(
            "회원가입",
            style: TextStyle(
              color: AppColors.gray600,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}