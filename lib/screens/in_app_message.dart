import 'package:another_flushbar/flushbar.dart';
import 'package:ego/models/ego_info_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/diary/diary.dart';
import '../sample/cmyk-196/sample_home_with_fcm.dart'; // 나중에 있을 main화면 완성본에 맞게 경로 수정
import '../theme/color.dart';
import 'diary/diary_view_screen.dart';

/**
 * 일기 작성 InAppMsg
 * */
void showFlushBarFromForegroundFirebase(
  RemoteMessage message
) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  Flushbar(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(24),
    borderColor: AppColors.gray400,
    margin: EdgeInsets.all(16),
    flushbarPosition: FlushbarPosition.TOP,
    isDismissible: true,
    // 수동 닫기 활성화
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // 좌우 슬라이드로만 닫기
    messageText: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: SvgPicture.asset("assets/icon/fcm_pencil.svg"),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '일기 작성 시간이 되었어요! 같이 작성해볼까요?',
                    style: TextStyle(
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '오늘은 어떤 일기가 만들어질까요?',
                    style: TextStyle(color: AppColors.gray900, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),

        Container(
          margin: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.deepPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  // EGO 일기 수정 화면으로 이동
                  // 여기서 AI에게 일기 요청 보내기
                  builder: (context) {
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
                          content:
                              '오늘은 가족들과 웃음이 가득한 아침 식사를 했어요. 맛있는 퐁듀를 2그릇이나 먹었어요.',
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

                    // 사용자 Id 기반 TodayEgo get 수행
                    // egoId + uid로 일기생성 요청
                    return DiaryViewScreen(diary: dummyDiary);
                  },
                ),
              );
            },
            child: Text(
              '작성하기',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  ).show(context);
}

void showFlushBarFromForegroundLocal() {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  Flushbar(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(24),
    borderColor: AppColors.gray400,
    margin: EdgeInsets.all(16),
    flushbarPosition: FlushbarPosition.TOP,
    isDismissible: true,
    // 수동 닫기 활성화
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // 좌우 슬라이드로만 닫기
    messageText: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: SvgPicture.asset("assets/icon/fcm_pencil.svg"),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '일기 작성 시간이 되었어요! 같이 작성해볼까요?',
                    style: TextStyle(
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '오늘은 어떤 일기가 만들어질까요?',
                    style: TextStyle(color: AppColors.gray900, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),

        Container(
          margin: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.deepPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  // EGO 일기 수정 화면으로 이동
                  // 여기서 AI에게 일기 요청 보내기
                  builder: (context) {
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
                          content:
                          '오늘은 가족들과 웃음이 가득한 아침 식사를 했어요. 맛있는 퐁듀를 2그릇이나 먹었어요.',
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

                    // 사용자 Id 기반 TodayEgo get 수행
                    // egoId + uid로 일기생성 요청
                    return DiaryViewScreen(diary: dummyDiary);
                  },
                ),
              );
            },
            child: Text(
              '작성하기',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  ).show(context);
}
