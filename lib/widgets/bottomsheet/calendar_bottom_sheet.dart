import 'package:ego/theme/color.dart';
import 'package:ego/utils/constants.dart';
import 'package:ego/widgets/diarycard/diary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// TODO: 일기 카드에 길이가 적용되지 않는 문제있음. 일단 자체 Padding으로 해결
class CalendarBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DraggableScrollableSheet(
        initialChildSize: 0.35, // 초기 값 설정 (부모 컴포넌트 기준 비율)
        minChildSize: 0.35, // 최소 값 설정 (부모 컴포넌트 기준 비율)
        maxChildSize: 1.0, // 최대 값 설정 (부모 컴포넌트 기준 비율)
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: AppColors.gray100,
            padding: EdgeInsets.symmetric(horizontal: 20.w), // TODO: 자체 패딩으로 해결
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                return DiaryCard( // TODO: DiaryCard 샘플
                  date: DateTime.now(),
                  emotions: [Emotion.happiness],
                  egoName: 'Ego 이름: $index',
                  story: '요약된 일기 내용을 보여줍니다.이날은 무슨일이 있었고, 어쩌고 저쩌고. 이러쿵 저러쿵. 이야기를 작성하게 됩니다. 마지막은 점점점',
                );
              },
            ),
          );
        }
      ),
    );
  }
}
