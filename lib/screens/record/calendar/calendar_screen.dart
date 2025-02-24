import 'package:ego/theme/color.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants.dart';
import '../../../widgets/diarycard/diary_card.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray400,
      child: Column(
        children: [
          DiaryCard(
            date: DateTime.now(),
            emotion: Emotion.happiness,
            egoName: 'Ego 이름',
            story: '요약된 일기 내용을 보여줍니다.이날은 무슨일이 있었고, 어쩌고 저쩌고. 이러쿵 저러쿵. 이야기를 작성하게 됩니다. 마지막은 점점점',
          ),
        ],
      )
    );
  }
}