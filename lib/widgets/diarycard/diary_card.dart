import 'package:ego/utils/constants.dart';
import 'package:ego/utils/util_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/color.dart';

class DiaryCard extends StatelessWidget {
  final DateTime date;
  final Emotion emotion;
  final String videoPlayPath = 'assets/icon/video_play.svg';
  final String egoName;
  final String story;

  const DiaryCard({super.key, required this.date, required this.emotion, required this.egoName, required this.story});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gradationBox(),
            _dateCard(),
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
                      UtilFunction.emotionTypeToPath(emotion),
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
            width: 24.w,
            height: 24.h,
          ),
        ],
      ),
    );
  }

  Widget _dateCard() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 8.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h,
        children: [
          Text(
            egoName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            story,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}