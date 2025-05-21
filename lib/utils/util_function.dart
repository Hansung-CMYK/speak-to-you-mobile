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
    return switch (emotionType) {
      Emotion.anger => 'assets/icon/emotion/anger.svg',
      Emotion.disappointment => 'assets/icon/emotion/disappointment.svg',
      Emotion.embarrassment => 'assets/icon/emotion/embarrassment.svg',
      Emotion.happiness => 'assets/icon/emotion/happiness.svg',
      Emotion.sadness => 'assets/icon/emotion/sadness.svg',
    };
  }

  // ego의 PersonalityList를 idList로 변환하는 함수 입니다.
  // (그룹채팅방을 firebasestore에서 관리하는데 personality_id값 즉, 정수로 되어있어서 필요합니다.)
  static int personalityTagToId(String personalityTag) {
    final Map<String, int> personalityMap = {
      '늘정주나': 1,
      '시간마술사': 2,
      '존댓말자동완성': 3,
      '식사개근상': 4,
      '유교휴먼': 5,
      'TMI장인': 6,
      '콘센트헌터': 7,
      '눈치n년차': 8,
      '혼밥초년생': 9,
      '회식병가자': 10,
      '줄서기본능': 11,
      '훈수스피커': 12,
      '애국열사': 13,
      '알코올엔진': 14,
      '연예계CEO': 15,
      '출퇴근금강불괴': 16,
      '넷미인': 17,
      '하트채굴자': 18,
      '광기계발자': 19,
      '상습괜찮러': 20,
      '배달VIP': 21,
      '수면채무자': 22,
      '고민사색가': 23,
      '감정장대봉': 24,
      '결정권위임자': 25,
      'MBTI목사': 26,
      '구매서기관': 27,
      '무도식여행가': 28,
      '인간명왕성': 29,
      '디지털인간': 30,
      '엄친아판별기': 31,
      'K-약속러': 32,
    };

    return personalityMap[personalityTag] ?? 0; // 존재하는 값이 없으면 0반환
  }
}