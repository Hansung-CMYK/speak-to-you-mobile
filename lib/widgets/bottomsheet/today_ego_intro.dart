import 'package:ego/screens/egoreview/ego_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';

/// 오늘의 EGO정보를 BottomSheet를 사용하여 보여줍니다.
/// context : 띄워질 부모의 context \[BuildContext]
/// egoInfoModel : 띄울 EGO의 정보 \[EgoInfoModel]
void showTodayEgoIntroSheet(
  BuildContext context,
  EgoInfoModel egoInfoModel, {
  bool isOtherEgo = false,
  VoidCallback? onChatWithEgo,
  VoidCallback? onChatWithHuman,
  String relationTag = "", // 관계 태그
  bool canChatWithHuman = false, // 사람과 채팅 가능한지 여부
  String unavailableReason = "", // 채팅 불가능한 이유
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.gray100,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: 600.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, right: 20.w, left: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _body(
                context,
                egoInfoModel,
                isOtherEgo,
                onChatWithEgo,
                onChatWithHuman,
                relationTag,
                canChatWithHuman,
                unavailableReason,
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// BottomSheet의 Header 부분 '제목, 닫기 버튼'으로 구성됨
///
/// \[context] : BottomSheet를 닫기 위함 \[BuildContext]
Widget _header(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 48.w),
      Text(
        '오늘의 EGO',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.gray900,
        ),
      ),
      IconButton(
        icon: SvgPicture.asset(
          'assets/icon/close.svg',
          width: 24.w,
          height: 24.h,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}

/// BottomSheet의 Body부분 EGO의 정보들을 보여줍니다.
///
/// \[egoInfoModel] : EGO의 정보를 가지고 있는 model입니다. \[EgoInfoModel]
/// \[context] : BottomSheet를 닫기 위해 context를 전달해 줍니다. \[BuildContext]
Widget _body(
  BuildContext context,
  EgoInfoModel egoInfoModel,
  bool isOtherEgo,
  VoidCallback? onChatWithEgo,
  VoidCallback? onChatWithHuman,
  String relationTag,
  bool canChatWithHuman,
  String unavailableReason,
) {
  return Column(
    children: [
      EgoInfoCard(
        egoInfoModel: egoInfoModel,
        isOtherEgo: isOtherEgo,
        relationTag: relationTag,
      ),
      _egoSpecificInfo(egoInfoModel),
      _footerButtons(
        context,
        isOtherEgo,
        onChatWithEgo,
        onChatWithHuman,
        canChatWithHuman,
        unavailableReason,
      ),
    ],
  );
}

/// Ego의 프로필이미지, 이름, 생일을 보여줍니다.
///
/// \[egoInfoModel] : EGO의 정보를 가지고 있습니다. \[EgoInfoModel]
/// Ego의 프로필이미지, 이름, 생일을 보여줍니다.
class EgoInfoCard extends StatefulWidget {
  final EgoInfoModel egoInfoModel;
  final bool isOtherEgo;
  final String relationTag;

  EgoInfoCard({
    required this.egoInfoModel,
    required this.isOtherEgo,
    required this.relationTag,
  });

  @override
  _EgoInfoCardState createState() => _EgoInfoCardState();
}

class _EgoInfoCardState extends State<EgoInfoCard> {
  bool isFavorite = false;
  int heartCount = 1200;

  @override
  void initState() {
    super.initState();

    if (!widget.isOtherEgo) {
      isFavorite = true;
    }

    //TODO heartCount 불러오는 로직 필요
    //TODO isFavorite 불러오는 로직 필요
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 24.h),
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(widget.egoInfoModel.egoIcon, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      children: [
                        if (widget.relationTag.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: _sizableTagWidget(
                              "assets/icon/pencil.svg",
                              AppColors.accent,
                              AppColors.white,
                              4,
                              widget.relationTag,
                              12,
                              FontWeight.w700,
                              size: 13,
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => EgoReviewScreen(
                                          egoInfoModel: widget.egoInfoModel,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        Text(
                          widget.egoInfoModel.egoName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _tagWidget(
                        "assets/icon/cake.svg",
                        AppColors.strongOrange,
                        AppColors.white,
                        4,
                        "생일",
                        12,
                        FontWeight.w700,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 4.w),
                        child: Text(
                          widget.egoInfoModel.egoBirth,
                          style: TextStyle(
                            height: 1.5.h,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray900,
                          ),
                        ),
                      ),
                      _tagWidget(
                        "",
                        AppColors.gray200,
                        AppColors.gray400,
                        100,
                        "D-${widget.egoInfoModel.calcRemainingDays()}",
                        10,
                        FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap:
                          widget.isOtherEgo
                              ? () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                  heartCount += isFavorite ? 1 : -1;
                                  // TODO: 하트 전송 API 호출
                                });
                              }
                              : null,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite
                                ? AppColors.strongOrange
                                : AppColors.gray400,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      NumberFormat('#,###').format(heartCount),
                      style: TextStyle(
                        color: AppColors.strongOrange,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Today EGO의 세부 내용 (성격, 자기소개)
///
/// \[egoInfoModel] : EGO 정보
Widget _egoSpecificInfo(EgoInfoModel egoInfoModel) {
  return Container(
    width: 353.w,
    height: 230.h,
    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 25.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tagWidget(
                "assets/icon/personality.svg",
                AppColors.gray100,
                AppColors.accent,
                4,
                "성격",
                14,
                FontWeight.w700,
              ),
              Text(
                egoInfoModel.egoPersonality,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.gray300, width: 1.h),
            ),
          ),
          height: 108.h,
          child: RawScrollbar(
            thumbVisibility: true,
            thickness: 3,
            thumbColor: AppColors.gray700,
            radius: Radius.circular(10.r),
            child: SingleChildScrollView(
              child: Text(
                egoInfoModel.egoSelfIntro,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// 확인 버튼
///
/// \[context] : 확인을 누르면 BottomSheet를 닫기 위함
Widget _footerButtons(
  BuildContext context,
  bool isOtherEgo,
  VoidCallback? onChatWithEgo,
  VoidCallback? onChatWithHuman,
  bool canChatWithHuman,
  String unavailableReason,
) {
  if (isOtherEgo) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EGO 버튼
              Expanded(
                child: TextButton(
                  onPressed: onChatWithEgo,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    backgroundColor: AppColors.strongOrange,
                  ),
                  child: Text(
                    "EGO와 채팅",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // 사람과 채팅 버튼 + 안내문
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: canChatWithHuman ? onChatWithHuman : null,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        backgroundColor:
                            canChatWithHuman
                                ? AppColors.strongOrange
                                : AppColors.gray300,
                      ),
                      child: Text(
                        "사람과 채팅",
                        style: TextStyle(
                          color:
                              canChatWithHuman
                                  ? AppColors.white
                                  : AppColors.gray600,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (!canChatWithHuman && unavailableReason.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          unavailableReason,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.gray600,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 60.h),
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          backgroundColor: AppColors.strongOrange,
        ),
        child: Text(
          "확인",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

/// 태그 모양을 가지는 위젯을 반환합니다.
///
/// \[iconPath] : icon의 경로\[String]
/// \[tagColor] : tag의 배경색\[Color]
/// \[fontColor] : tag의 글자 색\[Color]
/// \[borderRadius] : tag의 굴곡\[double]
/// \[text] : tag명\[String]
/// \[fontSize] : tag 글자 사이즈\[int]
/// \[fontWeight] : tag 글자 두께\[FontWeight]
Widget _tagWidget(
  String iconPath,
  Color tagColor,
  Color fontColor,
  double borderRadius,
  String text,
  int fontSize,
  FontWeight fontWeight, {
  VoidCallback? onClick,
}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: [
          if (iconPath != "") ...[
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: SvgPicture.asset(iconPath),
            ),
          ],
          Text(
            text,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _sizableTagWidget(
  String iconPath,
  Color tagColor,
  Color fontColor,
  double borderRadius,
  String text,
  int fontSize,
  FontWeight fontWeight, {
  VoidCallback? onClick,
  double size = 18.0,
}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: [
          if (iconPath != "") ...[
            Padding(
              padding: EdgeInsets.only(left: 2.w,right: 5.w),
              child: SvgPicture.asset(iconPath, width: size, height: size),
            ),
          ],
          Text(
            text + " ",
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    ),
  );
}
