import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/noticecard/notice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notice {
  final String category;
  final String title;
  final DateTime date;

  const Notice(this.category, this.title, this.date);
}

List<Notice> SAMPLE_DATA = [
  Notice("업데이트", "공지사항 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("공지", "공지사항 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("공지", "일반 공지 란은", DateTime(2024, 12, 29)),
  Notice("공지", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이벤트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
  Notice("업데이트", "공지사항 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("공지", "공지사항 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("공지", "일반 공지 란은", DateTime(2024, 12, 29)),
  Notice("공지", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이벤트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
  Notice("업데이트", "공지사항 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("공지", "공지사항 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("공지", "일반 공지 란은", DateTime(2024, 12, 29)),
  Notice("공지", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이벤트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
  Notice("업데이트", "공지사항 게시판에 제목이 길어질경우 두줄까지 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 29)),
  Notice("공지", "공지사항 게시판에 제목이 짧을 경우 한줄만 노출이 됩니다. 이렇게 말이죠", DateTime(2025, 1, 3)),
  Notice("공지", "일반 공지 란은", DateTime(2024, 12, 29)),
  Notice("공지", "이렇게 나타납니다.", DateTime(2024, 12, 24)),
  Notice("이벤트", "카테고리는 다음과 같이 나타납니다.", DateTime(2024, 12, 19)),
];

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  void cardMethod(BuildContext context) {
    // TODO: 화면 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: "공지사항"),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      color: AppColors.gray100,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => cardMethod(context),
            child: NoticeCard(
              category: SAMPLE_DATA[index].category,
              title: SAMPLE_DATA[index].title,
              date: SAMPLE_DATA[index].date,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1.h,
          color: AppColors.gray100,
        ),
        itemCount: SAMPLE_DATA.length,
      ),
    );
  }
}