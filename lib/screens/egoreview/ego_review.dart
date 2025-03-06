import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EgoReviewScreen extends StatefulWidget {
  final EgoInfoModel egoInfoModel; // 평가할 EGO

  const EgoReviewScreen({super.key, required this.egoInfoModel});

  @override
  State<EgoReviewScreen> createState() => _EgoReviewScreenState();
}

class _EgoReviewScreenState extends State<EgoReviewScreen> {
  late final EgoInfoModel egoInfoModel;

  @override
  void initState() {
    super.initState();
    this.egoInfoModel = widget.egoInfoModel;
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
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: SvgPicture.asset(
            'assets/icon/navi_back_arrow.svg',
            width: 24.w,
            height: 24.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          EgoInfoProfile(
            egoName: egoInfoModel.egoName,
            egoIconPath: egoInfoModel.egoIcon,
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
Widget EgoInfoProfile({required String egoName, required String egoIconPath}) {
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
              child: Image.asset(egoIconPath, width: 100.w, height: 100.h),
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
