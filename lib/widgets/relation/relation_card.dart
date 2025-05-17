import 'package:ego/utils/constants.dart';
import 'package:ego/utils/util_function.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/color.dart';

/// 사용자와 EGO의 관계가 요약되어 나타나는 화면이다.
///
/// TODO: 생성자는 일기 클래스(테이블) 완성 시, 수정할 것
class RelationCard extends StatelessWidget {
  /// [date] 관계 업데이트된 날짜
  final DateTime date;

  /// [relationName] 관계 이름
  final String relationName;

  /// [content] 관계 내용
  final String content;

  /// [recapIconPath] 관계 정보 아이콘 [상승, 하락, 유지]
  final String recapIconPath = 'assets/icon/video_play.svg';

  /// 사용자의 일기가 요약되어 나타나는 화면이다.
  ///
  /// [date] 일기가 작성된 날짜
  /// [emotion] 당일 사용자가 느낀 감정들
  /// [relationName] 일기를 작성해준 에고의 이름
  /// [content] 요약된 일기의 내용
  const RelationCard({
    super.key,
    required this.date,
    required this.relationName,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white, // 배경색 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r), // 모서리 굴곡 설정
      ),
      child: Container(
        // 일기 카드 크기 지정
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
    );
  }

  /// 카드의 그라데이션 영역
  Widget _gradationBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8.h,
        left: 12.w,
        right: 16.w,
        bottom: 8.h,
      ), // 컨테이너 작성 영역 할당
      decoration: ShapeDecoration(
        // 그라데이션 추가(피그마 활용)
        gradient: LinearGradient(
          begin: Alignment(1, 0),
          end: Alignment(-1, 0),
          colors: [
            AppColors.royalBlue,
            AppColors.amethystPurple,
            AppColors.softCoralPink,
            AppColors.vividOrange,
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ), // 영역 모서리 굴곡 추가
      ),
      child: Row(
        children: [
          Expanded(
            // Recap SvgButton을 우측으로 이동시키기 위함
            child: Row(
              spacing: 8.w, // 아이콘과 텍스트 간의 간격
              children: [
                Text(
                  UtilFunction.formatDateTime(
                    date,
                  ), // 현재 날짜를 "yyyy년 MM월 dd일" 형식으로 변환한다.
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(recapIconPath, width: 24.w, height: 24.h),
        ],
      ),
    );
  }

  /// 일기의 내용이 설명되는 영역
  Widget _dateCard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h, // `에고 이름`과 `일기 요약` 간의 간격
        children: [
          Text(
            // 일기를 작성해 준 에고의 이름
            relationName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          Text(
            // 요약된 일기의 내용
            content,
            maxLines: 2, // 최대 텍스트 영역(라인 수)
            overflow: TextOverflow.ellipsis, // 내용이 초과된다면, `...`로 표시
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
