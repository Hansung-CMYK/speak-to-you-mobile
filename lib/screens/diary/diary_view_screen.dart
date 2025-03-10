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

import 'helped_ego_info_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 임시 객체
class Diary {
  final String date;
  final String title;
  final String content;
  final String image;

  Diary({
    required this.date,
    required this.content,
    required this.image,
    required this.title,
  });
}

class DiaryViewScreen extends StatefulWidget {
  @override
  State<DiaryViewScreen> createState() => _DiaryViewScreenState();
}

class _DiaryViewScreenState extends State<DiaryViewScreen> {
  // TODO 일기 + 감정 + EGO 정보 API 요청 필요
  // 임시 감정
  final List<String> emotions = ['기쁨', '재미'];

  // 임시 주제 일기
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

  // 임시 EGO 정보
  final EgoInfoModel egoInfoModel = EgoInfoModel(
    id: '1',
    egoIcon: 'assets/image/ego_icon.png',
    egoName: 'Power',
    egoBirth: '2002/02/03',
    egoPersonality: '단순함, 바보, 멍청',
    egoSelfIntro:
        '크하하! 나는 최고로 귀엽고, 강하고, 멋진 피의 마녀, Power다! 인간 따위보다 우월한 악마다! 내 피를 다루는 능력으로 어떤 적이든 박살 내 줄 수 있지! 덴지 녀석이랑 계약해서 일하고 있긴 하지만, 솔직히 내가 없으면 아무것도 못 해! 머리도 좋고, 싸움도 잘하고, 심지어 미모까지 완벽하니까! 피 냄새 나는 전쟁터가 딱 나한테 어울리지! 하지만 배고프면 기운이 없으니까, 고기랑 피를 실컷 먹게 해준다면 너도 내 충성심을 얻을 수 있을지도 모르지! 크하하하!',
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
    return Scaffold(
      appBar: StackAppBar(title: '일기보기'),
      body: Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: RawScrollbar(
          thumbVisibility: true,
          thickness: 4.w,
          radius: Radius.circular(8.r),
          thumbColor: AppColors.gray700,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // edit(전체수정), share(전체공유) 버튼
                Row(
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
                          toastMsg: '전체 일기가 공유되었습니다.',
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
                                (context) => DiaryEditScreen(diaries: diaries),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                //감정 Container
                TodayEmotionContainer(emotions),

                // 날짜
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
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
                ...diaries
                    .asMap()
                    .map((index, diary) {
                      return MapEntry(
                        index,
                        DiaryContainer(
                          diary: diary,
                          containerId: index,
                        ),
                      );
                    })
                    .values,

                // 일기 작성해준 EGO 정보
                HelpedEgoInfoContainer(context, egoInfoModel),

                // 일기 저장 버튼
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 40.h),
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
  }
}
