import 'package:ego/models/chat/chat_content_model.dart';
import 'package:ego/models/chat/chat_topic_model.dart';
import 'package:ego/screens/change_topic/change_topic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MaterialApp(
          title: 'Ego',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: SampleHomeScreen()
      ),
    );
  }
}

class SampleHomeScreen extends StatelessWidget {

  // 임시 데이터
  List<ChatTopicModel> sampleChatTopics = [
    ChatTopicModel(
      id: '1',
      mainTopic: '점심을 먹었다.',
      subTopic: '오 점심을 어디서 드셨나요?',
      canWriteDiary: false,
      reason: '어디서',
      chats: [
        ChatContentModel(id: '1', topic: '점심', content: '안녕하세요!', time: '2025/03/08/08:00:00', isUser: false),
        ChatContentModel(id: '2', topic: '점심', content: '오늘 점심 뭐 먹을까?', time: '2025/03/08/08:05:00', isUser: true),
        ChatContentModel(id: '3', topic: '점심', content: '김치찌개 어때?', time: '2025/03/08/08:10:00', isUser: false),
        ChatContentModel(id: '4', topic: '점심', content: '좋아! 김치찌개 먹자', time: '2025/03/08/08:15:00', isUser: true),
        ChatContentModel(id: '5', topic: '점심', content: '오늘 날씨 좋다', time: '2025/03/08/08:20:00', isUser: false),
        ChatContentModel(id: '6', topic: '점심', content: '맞아, 따뜻해서 기분 좋다', time: '2025/03/08/08:25:00', isUser: true),
        ChatContentModel(id: '7', topic: '점심', content: '다 먹고 커피 한잔?', time: '2025/03/08/08:30:00', isUser: false),
        ChatContentModel(id: '8', topic: '점심', content: '좋다! 어디서 마실까?', time: '2025/03/08/08:35:00', isUser: true),
        ChatContentModel(id: '9', topic: '점심', content: '근처 카페에서 마시자', time: '2025/03/08/08:40:00', isUser: false),
        ChatContentModel(id: '10', topic: '점심', content: '알겠어! 그럼 가자', time: '2025/03/08/08:45:00', isUser: true),
      ],
    ),
    ChatTopicModel(
      id: '2',
      mainTopic: '영화 추천',
      subTopic: '왜 그 영화를 보신거에요?',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '영화 추천', content: '추천할 만한 영화 있어?', time: '2025/03/08/10:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '영화 추천', content: '최근에 재미있었던 영화는?', time: '2025/03/08/10:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '영화 추천', content: '어벤져스 시리즈 추천', time: '2025/03/08/10:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '영화 추천', content: '액션 영화 좋아?', time: '2025/03/08/10:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '영화 추천', content: '좋아, 어떤 영화?', time: '2025/03/08/10:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '영화 추천', content: '아이언맨은 어때?', time: '2025/03/08/10:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '영화 추천', content: '좋다! 그럼 아이언맨 보자', time: '2025/03/08/10:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '영화 추천', content: '영화는 언제 볼까?', time: '2025/03/08/10:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '영화 추천', content: '오늘 저녁에 볼까?', time: '2025/03/08/10:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '영화 추천', content: '좋아, 그럼 저녁에 영화 보자', time: '2025/03/08/10:45:00', isUser: false),
      ],
    ),
    ChatTopicModel(
      id: '3',
      mainTopic: '여행 계획',
      subTopic: '언제 떠나실 계획인가요?',
      canWriteDiary: false,
      reason: '언제',
      chats: [
        ChatContentModel(id: '1', topic: '여행 계획', content: '이번 여름에 어디 여행 갈까?', time: '2025/03/08/12:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '여행 계획', content: '해외 여행 생각 중이야', time: '2025/03/08/12:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '여행 계획', content: '유럽이나 미국 어때?', time: '2025/03/08/12:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '여행 계획', content: '유럽은 좋다! 언제 가는 거야?', time: '2025/03/08/12:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '여행 계획', content: '7월에 갈 거야', time: '2025/03/08/12:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '여행 계획', content: '그때 날씨가 좋겠네', time: '2025/03/08/12:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '여행 계획', content: '숙박은 어떻게 할 거야?', time: '2025/03/08/12:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '여행 계획', content: '호텔 예약할 예정', time: '2025/03/08/12:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '여행 계획', content: '좋은 호텔 찾았다!', time: '2025/03/08/12:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '여행 계획', content: '좋아, 그럼 예약하자', time: '2025/03/08/12:45:00', isUser: false),
      ],
    ),
    ChatTopicModel(
      id: '4',
      mainTopic: '운동',
      subTopic: '오랫동안 하셨네요! 근데 왜 운동을 하신거에요?',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '5',
      mainTopic: '5',
      subTopic: '555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '6',
      mainTopic: '6',
      subTopic: '66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '7',
      mainTopic: '7',
      subTopic: '777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '8',
      mainTopic: '8',
      subTopic: '88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '9',
      mainTopic: '9',
      subTopic: '999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '10',
      mainTopic: '10',
      subTopic: '1010101010110101010101101010101011010101010110101010101',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '11',
      mainTopic: '11',
      subTopic: '111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '12',
      mainTopic: '12',
      subTopic: '121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),
    ChatTopicModel(
      id: '13',
      mainTopic: '13',
      subTopic: '13131313131313131313131313131313131313131313131313',
      canWriteDiary: true,
      chats: [
        ChatContentModel(id: '1', topic: '운동', content: '오늘 운동할 거야?', time: '2025/03/08/14:00:00', isUser: true),
        ChatContentModel(id: '2', topic: '운동', content: '응, 헬스장 갈 거야', time: '2025/03/08/14:05:00', isUser: false),
        ChatContentModel(id: '3', topic: '운동', content: '오늘은 상체 운동 할 거야', time: '2025/03/08/14:10:00', isUser: true),
        ChatContentModel(id: '4', topic: '운동', content: '좋아, 나도 상체 할 거야', time: '2025/03/08/14:15:00', isUser: false),
        ChatContentModel(id: '5', topic: '운동', content: '오늘 운동 끝나고 뭐 할까?', time: '2025/03/08/14:20:00', isUser: true),
        ChatContentModel(id: '6', topic: '운동', content: '운동 끝나고 커피 마시자', time: '2025/03/08/14:25:00', isUser: false),
        ChatContentModel(id: '7', topic: '운동', content: '좋아, 근처 카페에서 마시자', time: '2025/03/08/14:30:00', isUser: true),
        ChatContentModel(id: '8', topic: '운동', content: '운동 후에 카페 가는 거 좋네', time: '2025/03/08/14:35:00', isUser: false),
        ChatContentModel(id: '9', topic: '운동', content: '그럼 끝나고 바로 가자', time: '2025/03/08/14:40:00', isUser: true),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),
        ChatContentModel(id: '10', topic: '운동', content: '알겠어, 운동 열심히 하고 가자', time: '2025/03/08/14:45:00', isUser: false),

      ],
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeTopicScreen(chatHistory : sampleChatTopics, isFinalEdit: true,)),
            );
          },
          child: const Text('대화 주제 변경 화면으로 이동'),
        ),
      ),
    );
  }
}

