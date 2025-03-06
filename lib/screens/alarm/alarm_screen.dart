import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/noticecard/notice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 공지사항이 나타나는 화면
class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: "알림"),
      body: _body(), // 공지사항 리스트가 나타나는 영역이다.
    );
  }

  /// 공지사항 리스트가 나타나는 영역
  Widget _body() {
    return Container(
      color: AppColors.gray100, // 피그마에선 greyScale200이다.
      child: ListView.separated( // 경계선이 존재하는 ListView를 생성한다.
        padding: EdgeInsets.symmetric(vertical: 12.h), // 당단 패딩 12 부여
        itemBuilder: (BuildContext context, int index) { // 객체를 동적으로 생성
          return NoticeCard(SAMPLE_DATA[index]); // 공지사항 정보를 보여주는 카드이다.
        },
        // 분계선 속성을 작성한다.
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1.h, // 경계선의 두께
          color: AppColors.gray200,
        ),
        itemCount: SAMPLE_DATA.length, // 샘플 데이터의 개수를 표시한다.
      ),
    );
  }
}

/// (임시) 공지사항 생성을 위한 샘플 공지사항 데이터
List<Notice> SAMPLE_DATA = [
  Notice("이벤트", "알림 게시판에 제목이 길어질 경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("공지", "알림 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("재호", "일반 알림 란은", DateTime(2024, 12, 29)),
  Notice("상준", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이준희", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
  Notice("업데이트", "알림 게시판에 제목이 길어질 경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("김", "알림 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("명", "일반 알림 란은", DateTime(2024, 12, 29)),
  Notice("준", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이벤트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
  Notice("공지", "알림 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("이벤트", "알림 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("에고", "일반 알림 란은", DateTime(2024, 12, 29)),
  Notice("에고", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이벤트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
  Notice("에고", "알림 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("공지", "알림 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("공지", "일반 알림 란은", DateTime(2024, 12, 29)),
  Notice("김재호", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("발로란트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
];