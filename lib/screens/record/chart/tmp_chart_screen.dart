import 'package:flutter/cupertino.dart';

import '../../../theme/color.dart';
import '../../../utils/constants.dart';
import '../../../widgets/diarycard/diary_card.dart';

class TmpChartScreen extends StatelessWidget {
  const TmpChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray400, // TODO: 영역 표시를 위한 테스트 코드
        child: Column(
          children: [
            DiaryCard( // TODO: DiaryCard 샘플
              date: DateTime.now(),
              emotions: [Emotion.happiness],
              egoName: 'Ego 이름',
              story: '요약된 일기 내용을 보여줍니다.이날은 무슨일이 있었고, 어쩌고 저쩌고. 이러쿵 저러쿵. 이야기를 작성하게 됩니다. 마지막은 점점점',
            ),
          ],
        )
    );
  }
}