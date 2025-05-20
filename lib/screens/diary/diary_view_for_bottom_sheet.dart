import 'package:ego/screens/diary/share_all_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ego/screens/diary/topic_container.dart';
import 'package:ego/screens/diary/topic_edit_screen.dart';
import 'package:ego/screens/diary/today_emotion_container.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/diary/diary.dart';
import '../../providers/diary/diary_provider.dart';
import 'helped_ego_info_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'one_sentence_review.dart';

/**
 * 캘린더 하단에 저장된 일기를 불러옵니다. [AI에게 요청하는 것 아님]
 * */
class DiaryViewForBottomSheet extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final int diaryId;

  const DiaryViewForBottomSheet({
    super.key,
    required this.scrollController,
    required this.diaryId,
  });

  @override
  ConsumerState<DiaryViewForBottomSheet> createState() =>
      _DiaryViewForBottomSheetState();
}

class _DiaryViewForBottomSheetState
    extends ConsumerState<DiaryViewForBottomSheet> {
  late FToast fToast;
  final Map<int, int> regenerateKeys = {};

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void increaseKey(int containerId) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        regenerateKeys[containerId] = (regenerateKeys[containerId] ?? 0) + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final diaryAsync = ref.watch(
      dailyDiaryProvider((
        diaryId: widget.diaryId,
        userId: "test", // uid는 시스템에 존재
      )),
    );

    return diaryAsync.when(
      data: (fetchedDiary) {
        Diary diary = fetchedDiary;

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
                        // 일기 수정 및 일기 공유 버튼
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

                          // 일기 수정화면 이동
                          SvgButton(
                            svgPath: 'assets/icon/edit_icon.svg',
                            width: 20.w,
                            height: 20.h,
                            radius: 16.r,
                            onTab: () async {
                              final updatedDiary = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          TopicEditScreen(diary: diary),
                                ),
                              );

                              if (updatedDiary != null &&
                                  updatedDiary is Diary) {
                                setState(() {
                                  diary = updatedDiary;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // 감정 Container
                    TodayEmotionContainer(diary.feeling),

                    // 날짜
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          bottom: 8.h,
                          top: 12.h,
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

                    // topic 정보 Container(topic제목, topic 내용, topic 이미지)
                      ...diary.topics
                          .asMap()
                          .entries
                          .where((entry) => entry.value.isDeleted != true)
                          .map((entry) {
                            final index = entry.key;
                            final topic = entry.value;

                            return TopicContainer(
                              topic: topic,
                              containerId: index,
                              regenerateKey: regenerateKeys[index] ?? 0,
                              onRegenerateKeyChanged: () => increaseKey(index),
                              isNewDiary: false,
                            );
                          }),

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
                          debugPrint(diary.toString());
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
        return Center(
          child: ElevatedButton(
            onPressed: () {
              ref.refresh(
                dailyDiaryProvider((
                  diaryId: widget.diaryId,
                  userId: "test", // userId 그대로 유지
                )),
              );
            },
            child: Text('다시 시도'),
          ),
        );
      },
      loading: () => Center(child: Text('불러오는 중...')),
    );
  }
}
