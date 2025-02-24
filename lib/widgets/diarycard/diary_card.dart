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
        child: Container( // 일기 카드 크기 지정
          width: 353.w, // 너비
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _gradationBox(context), // 카드의 그라데이션 영역
              _dateCard(), // 일기의 내용이 설명된 영역
            ],
          ),
        ),
      ),
    );
  }

  /// 카드의 그라데이션 영역
  Widget _gradationBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 16.w, bottom: 8.h), // 컨테이너 작성 영역 할당
      decoration: ShapeDecoration( // 그라데이션 추가(피그마 활용)
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // 영역 모서리 굴곡 추가
      ),
      child: Row(
        children: [
          Expanded( // Recap SvgButton을 우측으로 이동시키기 위함
            child: Row(
              spacing: 8.w, // 아이콘과 텍스트 간의 간격
              children: [
                Container( // 에고 감정 아이콘 표시
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration( // 아이코 주변 테두리 표시를 위함
                    shape: BoxShape.circle, // 원형으로 지정
                    border: Border.all(
                      color: AppColors.white, // 테두리 색상
                      width: 2, // 테두리 두께
                    ),
                  ),
                  child: ClipOval( // 하위 요소를 원형으로 만들어주는 컴포넌트
                    child: SvgPicture.asset( // 에고 감정 아이콘
                      UtilFunction.emotionTypeToPath(emotions[0]), // 첫번째 감정(가장 큰 감정으로 가정)이 나타난다.
                      fit: BoxFit.cover, // 빈 공간 없이 전체를 자른다.
                    ),
                  ),
                ),
                Text(
                  UtilFunction.formatDateTime(date), // 현재 날짜를 "yyyy년 MM월 dd일" 형식으로 변환한다.
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ),
          SvgButton( // 해당 일기의 RECAP으로 이동시켜주는 버튼이다.
            svgPath: recapIconPath,
            width: 24.w,
            height: 24.h,
            onTab: () => recapMethod(context),
          ),
        ],
      ),
    );
  }

  /// 일기의 내용이 설명되는 영역
  Widget _dateCard() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 8.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h, // `에고 이름`과 `일기 요약` 간의 간격
        children: [
          Text( // 일기를 작성해 준 에고의 이름
            egoName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text( // 요약된 일기의 내용
            story,
            maxLines: 2, // 최대 텍스트 영역(라인 수)
            overflow: TextOverflow.ellipsis, // 내용이 초과된다면, `...`로 표시
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