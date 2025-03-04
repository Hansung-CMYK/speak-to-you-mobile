import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// 공지사항의 세부 정보를 나타내는 화면
///
/// TODO: NoticeScreen develop에 merge되면, 생성자 Notice 클래스로 변경할 것
class NoticeDetailScreen extends StatelessWidget {
  /// 공지사항 종류
  final String category; // TODO: 임시 코드
  /// 공지사항 제목
  final String title; // TODO: 임시 코드
  /// 공지사항 날짜
  final DateTime date; // TODO: 임시 코드

  // final Notice notice; // TODO: 실제 사용될 코드

  /// 공지사항의 세부 정보를 나타내는 화면
  ///
  /// [category] 공지사항의 종류
  /// [title] 공지사항의 제목
  /// [date] 공지사항의 날짜
  // const NoticeDetailScreen({super.key, required this.notice});
  const NoticeDetailScreen({super.key, required this.category, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(), // 제목없이 back_arrow만 나타난다.
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView( // 본문이 내용을 초과했을 때 스크롤 되게 만듦
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h, // AppBar와의 간격 설정
          horizontal: 20.w, // 좌우 간격 설정
        ),
        child: Column(
          spacing: 24.h, // 피그마에서 Divider와 각 영역 간의 간격은 24.h이다.
          children: [
            _title(), // 공지사항의 정보가 나타나는 영역
            Divider( // title과 content의 영역을 구분
              indent: 1,
              color: AppColors.gray200,
            ),
            _content(), // 공지사항의 본문이 나타나는 영역
          ],
        ),
      ),
    );
  }

  /// 공지사항의 정보가 나타나는 영역
  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
      spacing: 4.h, // 각 정보들 간의 간격
      children: [
        Text( // 공지사항의 종류
          // notice.category,
          category,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text( // 공지사항 제목
          // notice.title,
          title,
          maxLines: 2, // 공지사항 제목은 최대 2줄까지 나타난다.
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis, // 오버될 시, '...'으로 표시
          ),
        ),
        Text( // 공지사항의 작성 일자
          // DateFormat('yyyy. MM. dd').format(notice.date),
          DateFormat('yyyy. MM. dd').format(date), // 공지사항이 나타나는 포멧 형태
          style: TextStyle(
            color: AppColors.gray600,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// 공지사항의 본문이 나타나는 영역이다.
  Widget _content() {
    return Html(
      // data: notice.content,
      data: SAMPLE_HTML,
    );
  }
}

/// 임시 본문 코드
/// `notice.content`를 대체하는 텍스트이다.
///
/// HTML이 적용되고 있음을 보여준다.
String SAMPLE_HTML = """
<h2>HTML이 적용된 영역입니다.</h2>
<p>설 연휴 기간 동안 [휴무 일정: 예시 - 2월 9일(금) ~ 2월 12일(월)] 운영이 중단되며,<br>
   해당 기간 동안 접수된 문의는 연휴 이후 순차적으로 처리될 예정입니다.</p>
<p>가족, 친지와 함께 행복한 명절 보내시고,<br>
   새해에는 건강과 행운이 가득하시길 바랍니다.<br>
   올 한 해도 많은 관심과 성원 부탁드립니다.</p>
<p><strong>새해 복 많이 받으세요! 🎉🙏</strong></p>
""";