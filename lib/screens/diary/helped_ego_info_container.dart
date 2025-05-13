import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ego/models/ego_info_model.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/bottomsheet/today_ego_intro.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget HelpedEgoInfoContainer(BuildContext context, EgoInfoModel egoInfoModel) {
  return Container(
    padding: EdgeInsets.only(bottom: 32.h, left: 20.w, right: 20.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.r),
        bottomRight: Radius.circular(20.r),
      ),
    ),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '일기를 도와준 친구',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),

        // EGO Profile 이미지 부분
        LayoutBuilder(
          builder: (context, constraints) {
            double size = constraints.maxWidth;

            return Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.warningBase,
                image: DecorationImage(
                  image: AssetImage(egoInfoModel.egoIcon),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            );
          },
        ),

        // EGO 이름 + 프로필 상세보기
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                egoInfoModel.egoName,
                style: TextStyle(
                  color: AppColors.gray900,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // 클릭 시 동작
                  showTodayEgoIntroSheet(context, egoInfoModel);
                },
                child: Row(
                  children: [
                    Text(
                      '프로필 보기',
                      style: TextStyle(
                        color: AppColors.gray400,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset('assets/icon/right_arrow.svg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
