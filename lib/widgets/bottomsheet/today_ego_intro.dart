import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';

/// 오늘의 EGO정보를 BottomSheet를 사용하여 보여줍니다.
Future<void> showTodayEgoIntroSheet(BuildContext context) async {
  //TODO 여기서 EGO 정보를 api로 전달 받음
  // 임시 모델
  EgoInfoModel egoInfoModel = new EgoInfoModel(
    id: '123',
    egoIcon: 'assets/image/ego_icon.png',
    egoName: 'Power Chan',
    egoBirth: '2024/02/25',
    egoPersonality: '단순함, 바보, 착함',
    egoSelfIntro:
        '안녕하세요! 저는 파워, 악마 사냥꾼이자 피의 악마입니다. 언제나 힘이 넘치고, 내 친구인 덴지를 위해서라면 뭐든 할 수 있어요. 때로는 성격이 거칠고, 충동적으로 행동하지만, 그런 저도 친구를 소중히 여기는 마음이 있답니다. 전투에서는 결코 물러서지 않으며, 적을 무찌르는 데에 진심이예요! 피를 통해 강해지는 저와 함께 모험을 떠나보세요!',
  );

  // 로딩 다이얼로그를 닫음
  Navigator.of(context).pop();

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
          padding: EdgeInsets.only(
            top: 24.h,
            right: 20.w,
            left: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(context), _body(egoInfoModel, context)],
          ),
        ),
      );
    },
  );
}

/// BottomSheet의 Header 부분 '제목, 닫기 버튼'으로 구성됨
///
/// [context] : BottomSheet를 닫기 위함 [BuildContext]
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
/// [egoInfoModel] : EGO의 정보를 가지고 있는 model입니다. [EgoInfoModel]
/// [context] : BottomSheet를 닫기 위해 context를 전달해 줍니다. [BuildContext]
Widget _body(EgoInfoModel egoInfoModel, BuildContext context) {
  return Column(
    children: [
      _egoInfoCard(egoInfoModel),
      _egoSpecificInfo(egoInfoModel),
      _checkButton(context),
    ],
  );
}

/// Ego의 프로필이미지, 이름, 생일을 보여줍니다.
///
/// [egoInfoModel] : EGO의 정보를 가지고 있습니다. [EgoInfoModel]
Widget _egoInfoCard(EgoInfoModel egoInfoModel) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 24.h),
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: Image.asset(egoInfoModel.egoIcon, fit: BoxFit.cover),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                egoInfoModel.egoName,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 생일 Tag부분
                _tagWidget(
                  "assets/icon/cake.svg",
                  AppColors.birthDayTagColor,
                  AppColors.white,
                  4,
                  "생일",
                  12,
                  FontWeight.w700,
                ),
                // 생일 날짜 부분
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 4.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    egoInfoModel.egoBirth,
                    style: TextStyle(
                      height: 1.5.h,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray900,
                    ),
                  ),
                ),
                // 생일까지 남은 일짜 (D-000)
                _tagWidget(
                  "",
                  AppColors.gray200,
                  AppColors.gray400,
                  100,
                  "D-${egoInfoModel.calcRemainingDays()}",
                  10,
                  FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

/// Today EGO의 세부 내용 (성격, 자기소개)
///
/// [egoInfoModel] : EGO 정보
Widget _egoSpecificInfo(EgoInfoModel egoInfoModel) {
  return Container(
    width: 353.w,
    height: 230.h,
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 20.w),
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
        Divider(color: AppColors.gray200, thickness: 1.h),
        Padding(
          padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
          child: SizedBox(
            height: 86.h,
            child: Scrollbar(
              thickness: 3,
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
        ),
      ],
    ),
  );
}

/// 확인 버튼
///
/// [context] : 확인을 누르면 BottomSheet를 닫기 위함
Widget _checkButton(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 60.h, bottom: 40.h),
    child: TextButton(
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        backgroundColor: AppColors.birthDayTagColor,
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

/// 태그 모양을 가지는 위젯을 반환합니다.
///
/// [iconPath] : icon의 경로[String]
/// [tagColor] : tag의 배경색[Color]
/// [fontColor] : tag의 글자 색[Color]
/// [borderRadius] : tag의 굴곡[double]
/// [text] : tag명[String]
/// [fontSize] : tag 글자 사이즈[int]
/// [fontWeight] : tag 글자 두께[FontWeight]
Widget _tagWidget(
  String iconPath,
  Color tagColor,
  Color fontColor,
  double borderRadius,
  String text,
  int fontSize,
  FontWeight fontWeight,
) {
  return Container(
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
  );
}
