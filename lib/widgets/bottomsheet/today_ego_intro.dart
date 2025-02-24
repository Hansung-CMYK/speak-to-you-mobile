import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

//
Future<void> showTodayEgoIntroSheet(BuildContext context) async {
  //TODO 여기서 EGO 정보를 api로 전달 받음

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(child: CircularProgressIndicator());
    },
  );

  // API 호출 시뮬레이션
  // await Future.delayed(Duration(seconds: 2));

  // 임시 모델
  EgoInfoModel egoInfoModel = new EgoInfoModel(
    id: '123',
    egoIcon: 'assets/image/egoIcon.png',
    egoName: 'Power Chan',
    egoBirth: '2024/05/14',
    egoPersonality: '단순함, 바보, 착함',
    egoSelfIntro:
        '안녕하세요! 저는 파워, 악마 사냥꾼이자 피의 악마입니다. 언제나 힘이 넘치고, 내 친구인 덴지를 위해서라면 뭐든 할 수 있어요. 때로는 성격이 거칠고, 충동적으로 행동하지만, 그런 저도 친구를 소중히 여기는 마음이 있답니다. 전투에서는 결코 물러서지 않으며, 적을 무찌르는 데에 진심이예요! 피를 통해 강해지는 저와 함께 모험을 떠나보세요!',
  );

  // 로딩 다이얼로그를 닫음
  Navigator.of(context).pop();

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(top: 24.h, right: 20.w, bottom: 0, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(context), _body(egoInfoModel)],
        ),
      );
    },
  );
}

// BottomSheet의 Header 부분 '제목, 닫기 버튼'으로 구성됨
Widget _header(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 48.w),
      Text(
        '오늘의 EGO',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
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

// BottomSheet의 Body부분 EGO의 정보들을 보여줍니다.
Widget _body(EgoInfoModel egoInfoModel) {
  return Expanded(child: Column(children: [_egoInfoCard(egoInfoModel)]));
}

Widget _egoInfoCard(EgoInfoModel egoInfoModel) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 0),
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.labelColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: SvgPicture.asset('assets/icon/cake.svg'),
                  ),
                  Text(
                    '생일',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
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
