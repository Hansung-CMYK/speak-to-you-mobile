import 'package:ego/models/diary/diary_create.dart';
import 'package:ego/screens/diary/share_all_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ego/screens/diary/topic_container.dart';
import 'package:ego/screens/diary/topic_edit_screen.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/screens/diary/today_emotion_container.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/diary/diary_provider.dart';
import 'helped_ego_info_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'one_sentence_review.dart';

/**
 * AI로 부터 받은 일기의 내용을 보여줍니다.
 * */
class DiaryViewScreen extends ConsumerStatefulWidget {
  const DiaryViewScreen({super.key});

  @override
  ConsumerState<DiaryViewScreen> createState() => _DiaryViewScreenState();
}

class _DiaryViewScreenState extends ConsumerState<DiaryViewScreen> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO 이후 uid에 따라 egoId를 조회합니다.

    final now = DateTime.now();
    final targetTime = DateTime(2025, 5, 17); // TODO이후에 현재 시간으로 변경
    //uid는 시스템에 존재
    final request = DiaryRequestModel(
      userId: "user_account_001",
      egoId: 1,
      date: targetTime,
    );

    final asyncDiary = ref.watch(diaryCreateFutureProvider(request));

    return Scaffold(
      appBar: StackAppBar(title: '일기보기'),
      body: asyncDiary.when(
        data: (diary) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: RawScrollbar(
              thumbVisibility: true,
              thickness: 4.w,
              radius: Radius.circular(8.r),
              thumbColor: AppColors.gray700,
              child: Container(
                color: AppColors.splitterColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20.w),
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
                                            DiaryEditScreen(diary: diary),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      //감정 Container
                      TodayEmotionContainer(diary.feeling),

                      // 날짜
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 8.h,
                            top: 12.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: Text(
                            diary.createdAt,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.gray600,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // 일기 정보 제공
                      ...diary.topics.asMap().map((index, topic) {
                        return MapEntry(
                          index,
                          TopicContainer(topic: topic, containerId: index),
                        );
                      }).values,

                      // 일기 작성해준 EGO 정보
                      HelpedEgoInfoContainer(egoId: diary.egoId),

                      SizedBox(height: 14.h),

                      // 오늘의 한 줄 요약
                      OneSentenceReview(diary.dailyComment),

                      // 일기 저장 버튼
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: 40.h,
                          left: 20.w,
                          right: 20.w,
                          top: 15.h,
                        ),
                        child: TextButton(
                          onPressed: () {
                            // TODO 일기 저장 API
                            final customBottomToast = CustomToast(
                              toastMsg: '일기가 저장되었습니다.',
                              iconPath: 'assets/icon/complete.svg',
                              backgroundColor: AppColors.accent,
                              fontColor: AppColors.white,
                            );
                            customBottomToast.init(fToast);

                            final position = 107.0.h;

                            customBottomToast.showBottomPositionedToast(
                              bottom: position,
                            );
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 15.h,
                            ),
                            backgroundColor: AppColors.strongOrange,
                          ),
                          child: Text(
                            "일기저장",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        error: (error, stack) {
          print('에러 발생: $error');
          print('스택트레이스: $stack');
          return Center(child: Text('에러가 발생했습니다: $error'));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
