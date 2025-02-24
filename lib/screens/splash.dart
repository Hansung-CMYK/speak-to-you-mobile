import 'package:ego/theme/color.dart';
import 'package:ego/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 224.h),
        child: Column(
          children: [
            Text(
              "HELLO EGO :)\n${SERVICE_NAME}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
                fontSize: 43.sp,
                height: 1.5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: SizedBox(
                width: 260.w,
                height: 72.h,
                child: SvgPicture.asset(
                  "assets/icon/splash_characters.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
