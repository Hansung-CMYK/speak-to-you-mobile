import 'package:ego/theme/color.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/diarycard/diary_card.dart';
import '../../../widgets/diarycard/sample_diary_card.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray400,
      child: Column(
        children: [
          DiaryCard(),
          SampleDiaryCard(),
        ],
      )
    );
  }
}