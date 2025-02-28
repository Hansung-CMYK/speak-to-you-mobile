import 'package:ego/widgets/calendar_indicator.dart';
import 'package:ego/widgets/emotion_chart.dart';
import 'package:ego/widgets/emotion_filter.dart';
import 'package:flutter/cupertino.dart';

class TmpChartScreen extends StatelessWidget {
  const TmpChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: 영역 표시를 위한 테스트 코드
      child: Column(
        children: [CalendarIndicator(), EmotionChart(), EmotionFilter()],
      ),
    );
  }
}
