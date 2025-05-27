import 'package:ego/models/diary/diary_create.dart';
import 'package:ego/providers/ego_provider.dart';
import 'package:ego/screens/diary/share_all_diary.dart';
import 'package:ego/screens/egoreview/ego_review.dart';
import 'package:ego/services/diary/diary_service.dart';
import 'package:ego/services/ego/ego_service.dart';
import 'package:ego/utils/shared_pref_helper.dart';
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

import 'package:ego/models/diary/diary.dart';
import 'package:ego/providers/diary/diary_provider.dart';
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
  final Map<int, int> regenerateKeys = {};
  late String uid;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    uid = SharedPrefService.getUid()!;
  }

  // 같은 prompt로 이미지생성이 가능하도록
  // provider에 key값을 추가해 provider의 고유값 판단
  void increaseKey(int containerId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        regenerateKeys[containerId] = (regenerateKeys[containerId] ?? 0) + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final todayEgoSync = ref.watch(todayEgoProvider(uid));

    return todayEgoSync.when(
      data: (todayEgo) {
        final targetTime = DateTime(2025, 5, 25); // TODO이후에 현재 시간으로 변경
        //uid는 시스템에 존재
        final request = DiaryRequestModel(
          userId: uid,
          egoId: todayEgo.id!,
          date: targetTime,
        );

        final asyncDiary = ref.watch(diaryCreateFutureProvider(request));

        return Scaffold(
          appBar: StackAppBar(title: '일기보기'),
          body: asyncDiary.when(
            data: (fetchedDiary) {
              Diary diary = fetchedDiary;

              bool isAllUrlsNotNull = diary.topics.every(
                (topic) => topic.url != null,
              );

              // 해당 함수를 호출함 으로써 setState가 호출되고 이는 현재 화면을 reBuild시킨다.
              // 이에따라 isAllUrlsNotNull이 재검증하게 되고
              // 저장버튼의 활성화 여부를 판단한다. 즉, topic의 url이 채워지면 null값을 확인하여 모든 이미가 load되도록 함
              void updateTopicUrl(int index, String newUrl) {
                setState(() {
                  diary.topics[index].url = newUrl;
                });
              }

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
                                  onRegenerateKeyChanged:
                                      () => increaseKey(index),
                                  isNewDiary: true,
                                  updateUrl:
                                      (String newUrl) =>
                                          updateTopicUrl(index, newUrl),
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
                              top: 15.h,
                            ),
                            child: TextButton(
                              onPressed:
                                  isAllUrlsNotNull
                                      ? () async {
                                        debugPrint(diary.toString());

                                        try {
                                          // 일기 저장 요청
                                          await DiaryService.saveDiary(diary);

                                          final customBottomToast = CustomToast(
                                            toastMsg: '일기가 저장되었습니다.',
                                            iconPath:
                                                'assets/icon/complete.svg',
                                            backgroundColor: AppColors.accent,
                                            fontColor: AppColors.white,
                                          );
                                          customBottomToast.init(fToast);
                                          customBottomToast
                                              .showBottomPositionedToast(
                                                bottom: 107.0.h,
                                              );

                                          final ego = await ref.read(
                                            egoByIdProviderV2(
                                              request.egoId,
                                            ).future,
                                          );

                                          // ✅ 성공 시 ego 평가 화면으로 이동
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => EgoReviewScreen(
                                                    egoModelV2: ego,
                                                  ),
                                            ),
                                          );
                                        } catch (error) {
                                          // 일기 저장 에러 시 토스트만 띄우고 이동 안 함
                                          final errorToast = CustomToast(
                                            toastMsg: '일기 저장 불가',
                                            iconPath:
                                                'assets/icon/error_icon.svg',
                                            backgroundColor: AppColors.red,
                                            fontColor: AppColors.white,
                                          );
                                          errorToast.init(fToast);
                                          errorToast.showBottomPositionedToast(
                                            bottom: 107.0.h,
                                          );
                                        }
                                      }
                                      : null,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 15.h,
                                ),
                                backgroundColor:
                                    isAllUrlsNotNull
                                        ? AppColors.strongOrange
                                        : AppColors.gray400,
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
                    ref.refresh(diaryCreateFutureProvider(request));
                  },
                  child: Text('일기 생성 다시 시도'),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
      error: (error, stack) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              ref.refresh(todayEgoProvider(uid));
            },
            child: Text('다시 시도'),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
