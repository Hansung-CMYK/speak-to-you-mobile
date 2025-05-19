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

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
      data: (diary) {
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
                      child: Row( // 일기 수정 및 일기 공유 버튼
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
                                          TopicEditScreen(diary: diary),
                                ),
                              );
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

                    SizedBox(height: 35.h),
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
      loading: () => SizedBox.shrink(),
    );
  }
}
