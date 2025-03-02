import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ego/theme/color.dart';

class DiaryViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '일기보기',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icon/back_arrow.svg',
            width: 24.w,
            height: 24.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, right: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: SvgPicture.asset(
                      'assets/icon/share_icon.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: SvgPicture.asset(
                      'assets/icon/edit_icon.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
