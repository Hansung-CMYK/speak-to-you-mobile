import 'package:ego/utils/constants.dart';
import 'package:intl/intl.dart';

class UtilFunction {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat("yyyy년 MM월 dd일").format(dateTime);
  }

  static String emotionTypeToPath(Emotion emotionType) {
    return switch(emotionType) {
      Emotion.anger => 'assets/icon/emotion/anger.svg',
      Emotion.disappointment => 'assets/icon/emotion/disappointment.svg',
      Emotion.embarrassment => 'assets/icon/emotion/embarrassment.svg',
      Emotion.happiness => 'assets/icon/emotion/happiness.svg',
      Emotion.sadness => 'assets/icon/emotion/sadness.svg',
    };
  }
}