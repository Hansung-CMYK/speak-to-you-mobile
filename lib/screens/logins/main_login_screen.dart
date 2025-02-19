import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/button/custom_button1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLoginScreen extends StatelessWidget {
  void emailClickMethod(BuildContext context) {

  }

  void naverClickMethod(BuildContext context) {

  }

  void googleClickMethod(BuildContext context) {

  }

  void signUpClickMethod(BuildContext context) {

  }

  const MainLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: ""), // TODO: 임시 배치
      body: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _slogan(),
              SizedBox(height: 56.h,),
              _title(),
              SizedBox(height: 52.h,),
              _buttons(context),
              SizedBox(height: 24.h,),
              _textLogo(context),
            ],
          ),
        )
      ),
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
        CustomButton1(
          text: "이메일로 계속하기",
          confirmMethod: () => emailClickMethod(context),
          height: 48.h,
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
        CustomButton1(
          text: "네이버로 계속하기",
          confirmMethod: () => naverClickMethod(context),
          height: 48.h,
        ),
        CustomButton1(
          text: "Google로 계속하기",
          confirmMethod: () => googleClickMethod(context),
          height: 48.h,
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