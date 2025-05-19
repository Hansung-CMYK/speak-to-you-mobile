import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/diary/diary.dart';
import '../../screens/diary/diary_view_screen.dart';
import '../../theme/theme.dart';

void main() {
  runApp(const DiaryViewApp());
}

class DiaryViewApp extends StatelessWidget {
  const DiaryViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: 'Ego',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: SampleHomeScreen(),
          ),
    );
  }
}

class SampleHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dummyDiary = Diary(
      diaryId: 1,
      uid: 'test',
      egoId: 1,
      feeling: '활기찬, 뿌듯한',
      dailyComment: '오늘은 아주 활발한 하루였어요! 특히 냥 체를 많이 사용하셨네요!',
      createdAt: '2025-05-06',
      keywords: ['엥', '진짜?', '아니', '근데'],
      topics: [
        Topic(
          topicId: 1,
          diaryId: 1,
          title: '웃음이 가득한 아침 식사',
          content: '오늘은 가족들과 웃음이 가득한 아침 식사를 했어요. 맛있는 퐁듀를 2그릇이나 먹었어요.',
          url:
              'https://fal.media/files/penguin/vX86khImmFa6A8JgBpD0g_66de42358e1146a8a4b689d1e0e96e1d.jpg',
          isDeleted: false,
        ),
        Topic(
          topicId: 2,
          diaryId: 1,
          title: '나른한 오후의 만난 삼색 고양이',
          content: '노을이 질 때 즈음에 삼색 고양이를 봤어요. 참치를 간식으로 주었어요.',
          url:
              'https://fal.media/files/penguin/vX86khImmFa6A8JgBpD0g_66de42358e1146a8a4b689d1e0e96e1d.jpg',
          isDeleted: false,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('홈 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryViewScreen(diary: dummyDiary),
              ),
            );
          },
          child: const Text('Diary 화면으로 이동'),
        ),
      ),
    );
  }
}
