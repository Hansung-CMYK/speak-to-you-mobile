import 'package:ego/utils/constants.dart';
import 'package:intl/intl.dart';

/// 서비스 전체에서 공통적으로 이용하는 함수를 모아둔 클래스
class UtilFunction {
  /// `DateTime`의 날짜를 "yyyy년 MM월 dd일" 형식으로 변환해주는 함수
  ///
  /// [dateTime] 변환하고 싶은 날짜
  static String formatDateTime(DateTime dateTime) {
    return DateFormat("yyyy년 MM월 dd일").format(dateTime);
  }

  /// 감정 타입에 맞는 asset을 반환해주는 함수
  ///
  /// [emotionType] 반환받고 싶은 감정 종류
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