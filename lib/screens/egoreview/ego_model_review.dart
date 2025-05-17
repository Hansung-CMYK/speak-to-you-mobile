import 'dart:typed_data';

import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'emoji_rate_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EgoModelReviewScreen extends StatefulWidget {
  final EgoModelV2 egoModelV2; // 평가할 EGO

  const EgoModelReviewScreen({super.key, required this.egoModelV2});

  @override
  State<EgoModelReviewScreen> createState() => _EgoModelReviewScreenState();
}

class _EgoModelReviewScreenState extends State<EgoModelReviewScreen> {
  late final EgoModelV2 egoModelV2;
  int totalRate = 0;
  int solvingProblemRate = -1; // 대화의 흐름(문제해결능력) 점수 저장
  int empathyRate = -1; // 대화의 온도(공감능력) 점수 저장

  @override
  void initState() {
    super.initState();
    this.egoModelV2 = widget.egoModelV2;
  }

  // 클릭된 아이콘(점수)를 가져오기 위한 함수 (1~3점)
  void _handleProblemRating(int rating) {
    setState(() {
      solvingProblemRate = rating;
    });
  }

  // 클릭된 아이콘(점수)를 가져오기 위한 함수 (1~3점)
  void _handleEmpathyRating(int rating) {
    setState(() {
      empathyRate = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepPrimary,
        centerTitle: true,
        title: Text(
          'EGO 평가하기',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
        ),
        leading: IconButton(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 3.w),
          constraints: BoxConstraints(),
          icon: SvgPicture.asset(
            'assets/icon/navi_back_arrow.svg',
            width: 18.w,
            height: 16.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // EGO 정보를 보여주는 부분 + 건너뛰기 버튼
          EgoInfoProfile(
            egoName: egoModelV2.name,
            profileImage: egoModelV2.profileImage,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // EGO 총평 부분
                Container(
                  padding: EdgeInsets.only(top: 28.h, bottom: 16.h),
                  child: Column(
                    children: [
                      Text(
                        '오늘 EGO는 어떠셨나요?',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray900,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(
                            'assets/icon/total_rate_clicked.svg',
                          ),
                          half: SvgPicture.asset(
                            'assets/icon/total_rate_clicked.svg',
                          ),
                          empty: SvgPicture.asset('assets/icon/total_rate.svg'),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 6.w),
                        onRatingUpdate: (rating) {
                          setState(() {
                            totalRate = rating.toInt();
                          });
                        },
                      ),

                      Container(
                        height: 21.h,
                        child: Text(
                          totalRate == 0 ? '선택하세요' : '${totalRate}점',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color:
                            totalRate == 0
                                ? AppColors.gray400
                                : AppColors.errorDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 대화의 흐름(문제해결능력) 평가 부분
                EmojiRateBar(
                  title: '대화의 흐름은 어떠신가요?',
                  onRatingSelected: _handleProblemRating,
                ),

                // 대화의 온도(공감능력) 평가 부분
                EmojiRateBar(
                  title: '대화의 온도는 어떠신가요?',
                  onRatingSelected: _handleEmpathyRating,
                ),
              ],
            ),
          ),

          Spacer(),

          // 평가완료 버튼
          reviewCompleteBtn(
            context,
                () => {
              // TODO 평가 정보 송신 및 화면 전환
            },
            totalRate != 0 && solvingProblemRate != -1 && empathyRate != -1,
          ),
        ],
      ),
    );
  }
}

/// 건너뛰기 버튼을 가지며, Ego이름과 아이콘을 보여줍니다.
///
/// egoName : EGO 이름 [egoName]
/// egoIconPath : EGO 아이콘 [egoIconPath]
Widget EgoInfoProfile({
  required String egoName,
  required Uint8List? profileImage,
}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Column(
        children: [
          Container(color: AppColors.deepPrimary, height: 76.h), // 상단 배경 색상
          Container(color: AppColors.white, height: 80.h), // 하단 배경 색상
        ],
      ),

      Positioned(
        top: 24.h,
        child: Column(
          children: [
            // EGO 프로필
            CircleAvatar(
              radius: 50.w,
              backgroundColor: AppColors.transparent,
              child: profileImage != null
                  ? Image.memory(profileImage, width: 100.w, height: 100.h, fit: BoxFit.cover)
                  : Image.asset('assets/image/ego_icon.png', width: 100.w, height: 100.h, fit: BoxFit.cover), // 기본 이미지
            ),

            SizedBox(height: 8.h),

            // EGO 이름
            Text(
              egoName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
              ),
            ),
          ],
        ),
      ),

      // 건너뛰기 버튼
      Positioned(
        right: 20.w,
        child: Container(
          height: 23.h,
          child: TextButton(
            onPressed: () {
              // TODO 일기 작성 화면으로 이동필요
            },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              '건너뛰기',
              style: TextStyle(
                color: AppColors.gray100,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

/// 평가 완료 버튼
///
/// context : Dialog를 띄우기 위함 [BuildContext]
/// onConfirm : 확인 버튼을 눌렀을 때의 동작[VoidCallback]
/// isEnable : 버튼 활성화 여부 [bool]
Widget reviewCompleteBtn(
    BuildContext context,
    VoidCallback onConfirm,
    bool isEnable,
    ) {
  return Container(
    padding: EdgeInsets.only(right: 20.w, bottom: 40.h, left: 20.w),
    width: double.infinity,
    child: TextButton(
      onPressed:
      isEnable
          ? () async {
        bool? isConfirm = await showConfirmDialog(
          context: context,
          title: 'EGO 평가를 완료했어요!',
          content: '평가는 앞으로 매칭될 EGO에 반영됩니다.',
          dialogType: DialogType.success,
          confirmText: '확인',
          cancelText: '취소',
        );

        if (isConfirm != null && isConfirm) {
          // 확인을 누른 경우
          onConfirm();
        }
      }
          : null,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        backgroundColor: isEnable ? AppColors.deepPrimary : Colors.grey,
      ),
      child: Text(
        "평가완료",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
