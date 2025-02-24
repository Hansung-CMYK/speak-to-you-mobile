import 'package:ego/utils/util_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/color.dart';

class DiaryCard extends StatelessWidget {
  final DateTime date = DateTime.now();
  final String emotionPath = 'assets/icon/emotion/happiness.svg';
  final String videoPlayPath = 'assets/icon/video_play.svg';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 353.w,
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            _gradationBox(),
          ],
        ),
      ),
    );
  }

  Widget _gradationBox() {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 12, right: 16, bottom: 8),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1, 0),
          end: Alignment(-1, 0),
          colors: [
            AppColors.vividOrange,
            AppColors.softCoralPink,
            AppColors.amethystPurple,
            AppColors.royalBlue,
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              spacing: 8.w,
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white, // 테두리 색상
                      width: 2, // 테두리 두께
                    ),
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      emotionPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  UtilFunction.formatDateTime(date),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ),
          SvgPicture.asset(
            videoPlayPath,
          ),
        ],
      ),
    );
  }
}