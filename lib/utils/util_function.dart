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

  // relation tag값을 기반으로 사람과 채팅할 수 있는지 결정합니다.
  static bool relationToHumanChatPossible(String? relation){

    if(relation ==null ) return false;

    const positiveOrNeutralEmotions = {
      "감사",
      "격려",
      "공감",
      "감탄",
      "호감",
      "애정",
      "신뢰",
      "친근감",
      "존경",
      "지원",
      "희망",
      "위로",
      "연민",
      "흥미",
      "흥분",
      "호기심(긍정)",
      "놀람",
      "호기심(부정)",
      "무관심",
    };

    return positiveOrNeutralEmotions.contains(relation);
  }

  static String mapEmotionToCategory(String emotion) {
    switch (emotion) {
      case '경멸':
      case '분노':
      case '짜증':
      case '억울함':
      case '실망':
      case '무관심':
      case '질투':
        return '부정적';

      case '불안':
      case '경계심':
        return '불안한';

      case '슬픔(연민)':
      case '호기심(부정)':
        return '지루한';

      case '위로':
      case '격려':
      case '친근감':
      case '지원':
        return '원만한';

      case '희망':
      case '호감':
      case '신뢰':
        return '만족한';

      case '애정':
      case '감탄':
        return '즐거운';

      case '존경':
      case '감사':
        return '매력적';

      case '호기심(긍정)':
      case '흥분':
      case '흥미':
      case '공감':
      case '연민':
        return '즐거운';

      case '놀람':
        return '원만한'; // 또는 상황에 따라 분기 처리 가능

      default:
        return '기타';
    }
  }


}