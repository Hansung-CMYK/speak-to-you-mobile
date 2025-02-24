import 'package:ego/utils/constants.dart';
import 'package:ego/utils/util_function.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/color.dart';

/// 사용자의 일기가 요약되어 나타나는 화면이다.
///
/// `캘린더`, `감정차트` 스크린에서 이용한다.
/// TODO: 생성자는 일기 클래스(테이블) 완성 시, 수정할 것
class DiaryCard extends StatelessWidget {
  /// [date] 일기가 작성된 날짜
  final DateTime date;
  /// [emotion] 당일 사용자가 느낀 감정들
  final List<Emotion> emotions;
  /// [egoName] 일기를 작성해준 에고의 이름
  final String egoName;
  /// [story] 요약된 일기의 내용
  final String story;

  /// [recapIconPath] 리캡보기 아이콘의 경로
  final String recapIconPath = 'assets/icon/video_play.svg';

  /// 사용자의 일기가 요약되어 나타나는 화면이다.
  ///
  /// [date] 일기가 작성된 날짜
  /// [emotion] 당일 사용자가 느낀 감정들
  /// [egoName] 일기를 작성해준 에고의 이름
  /// [story] 요약된 일기의 내용
  const DiaryCard({super.key, required this.date, required this.emotions, required this.egoName, required this.story});

  /// 일기보기 화면으로 이동하는 함수이다.
  void diaryMethod(BuildContext context) {
    Navigator.pushNamed(context, 'Diary');
  }

  /// RECAP 화면으로 이동하는 함수이다.
  void recapMethod(BuildContext context) {
    Navigator.pushNamed(context, 'Recap');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // 카드 위젯을 클릭 시, 해당 일기로 이동한다.
      onTap: () => diaryMethod(context),
      child: Card(
        color: AppColors.white, // 배경색 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // 모서리 굴곡 설정
        ),
        child: Container(
          width: 353.w,
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _gradationBox(context),
              _dateCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gradationBox(BuildContext context) {
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
                      UtilFunction.emotionTypeToPath(emotions[0]),
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
          SvgButton(
            svgPath: recapIconPath,
            width: 24.w,
            height: 24.h,
            onTab: () => recapMethod(context),
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