import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// 공지사항 정보를 보여주는 카드
class NoticeCard extends StatelessWidget {
  /// 공지사항 정보가 담겨있는 객체이다.
  final Notice notice;

  /// 공자사항 정보를 보여주는 카드
  /// [notice] 공지사항 정보가 담겨있는 객체이다.
  const NoticeCard(this.notice, {super.key});

  /// 관련된 세부 공지사항으로 이동하는 함수
  void cardMethod(BuildContext context) {
    // TODO: 화면 이동
  }
  
  @override
  Widget build(BuildContext context) {
    // 카드 클릭 시 상호작용을 추가하기 위함
    return GestureDetector(
      onTap: () => cardMethod(context),
      child: Container(
        width: 393.w, // 컨테이너 크기 고정
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // 패딩 추가
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 끝에 화살표 아이콘을 배치하기 위함
          spacing: 24.w, // 버튼과 아이콘 간의 패딩 추가
          children: [
            Expanded( // Text가 화면을 뚫고 나가는 오류 제한
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                spacing: 4.h, // 위젯 간 간격 추가
                children: [
                  Text( // 카테고리 텍스트 정보
                    notice.category,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text( // 공지사항 제목 텍스트 정보
                    notice.title,
                    maxLines: 2,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text( // 작성 날짜 텍스트 정보
                    DateFormat('yyyy. MM. dd').format(notice.date), // 날짜 서식 추가
                    style: TextStyle(
                      color: AppColors.gray600, // 피그마에선 greyScale500이다.
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon( // 세부 공지사항으로 이동할 수 있음을 보여주는 아이콘
              size: 20.w,
              Icons.keyboard_arrow_right_rounded,
              color: AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}

/// (임시) 공지사항 생성을 위한 최소 속성 정보
class Notice {
  final String category;
  final String title;
  final DateTime date;

  const Notice(this.category, this.title, this.date);
}