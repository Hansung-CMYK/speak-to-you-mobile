import 'package:ego/screens/diary/share_all_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ego/models/ego_info_model.dart';
import 'package:ego/screens/diary/diary_container.dart';
import 'package:ego/screens/diary/diary_edit_screen.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/screens/diary/today_emotion_container.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:http/http.dart';

import 'diary_view_screen.dart';
import 'helped_ego_info_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'one_sentence_review.dart';

class DiaryViewForBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final int diaryId;

  const DiaryViewForBottomSheet({super.key, required this.scrollController, required this.diaryId});

  @override
  State<DiaryViewForBottomSheet> createState() =>
      _DiaryViewForBottomSheetState();
}

class _DiaryViewForBottomSheetState extends State<DiaryViewForBottomSheet> {
  final List<String> emotions = ['기쁨', '재미'];

  final List<Diary> diaries = [
    Diary(
      date: '2025/02/28',
      title: '친구랑 밥',
      content:
      '오늘은 친구랑 맛있는 음식을 먹으러 갔다. 오랜만에 만나서 그런지 더욱 맛있게 느껴졌고, 웃음꽃을 피우며 즐거운 시간을 보냈다. 음식도 맛있었고, 대화도 흥미로워서 시간 가는 줄 몰랐다. 너무 행복한 하루였다.',
      image: 'assets/image/first_diary_sample_image.png',
    ),
    Diary(
      date: '2025/02/28',
      title: '친구랑 축구',
      content:
      '오늘 친구랑 축구를 하러 갔다. 날씨도 맑고 기분도 좋았다. 열심히 뛰고, 서로 패스하며 팀워크를 발휘했는데, 결국 멋진 골도 넣었다. 피곤했지만 즐겁고 시원한 하루였다. 같이 운동하니까 더 가까워진 느낌!',
      image: 'assets/image/second_diary_sample_image.png',
    ),
  ];

  final EgoInfoModel egoInfoModel = EgoInfoModel(
    id: '1',
    egoIcon: 'assets/image/ego_icon.png',
    egoName: 'Power',
    egoBirth: '2002/02/03',
    egoPersonality: '단순함, 바보, 멍청',
    egoSelfIntro: '크하하! 나는 최고로 귀엽고, 강하고, 멋진 피의 마녀, Power다!...',
  );

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Container(
        color: AppColors.white,
        child: RawScrollbar(
          thumbVisibility: true,
          thickness: 4.w,
          radius: Radius.circular(8.r),
          thumbColor: AppColors.gray700,
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.gray300,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    width: 40.w,
                    height: 4.h,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(right: 20.w),
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgButton(
                        svgPath: 'assets/icon/share_icon.svg',
                        width: 20.w,
                        height: 20.h,
                        radius: 16.r,
                        onTab: () {
                          // TODO 일기 공유시 템플렛 필요
                          final customToast = CustomToast(
                            toastMsg: '일기가 공유되었습니다.',
                            iconPath: 'assets/icon/complete.svg',
                            backgroundColor: AppColors.accent,
                            fontColor: AppColors.white,
                          );
                          customToast.init(fToast);

                          shareAllDiary('전체 공유', customToast);
                        },
                      ),
                      SizedBox(width: 12.w),
                      SvgButton(
                        svgPath: 'assets/icon/edit_icon.svg',
                        width: 20.w,
                        height: 20.h,
                        radius: 16.r,
                        onTab: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DiaryEditScreen(diaries: diaries),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // 감정 Container
                TodayEmotionContainer(emotions),

                // 날짜
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left:20.w,bottom: 8.h, top: 12.h),
                    child: Text(
                      diaries[0].date,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                // 일기 정보 제공
                ...diaries.asMap().map((index, diary) {
                  return MapEntry(
                    index,
                    DiaryContainer(diary: diary, containerId: index),
                  );
                }).values,

                // 일기 작성해준 EGO 정보
                HelpedEgoInfoContainer(context, egoInfoModel),

                SizedBox(height: 14.h),

                // 오늘의 한 줄 요약
                OneSentenceReview(
                  "홍길동 에고와 가장 많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이많이 대화하고, 의성어를 주로 사용해 배드민턴 이야기를 했어요.",
                ),

                SizedBox(height : 35.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
