import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';
import '../../theme/color.dart';

/**
 * Main화면 상단에 보여지는 EGO List의 Item을 만듭니다.
 *
 * @param assetPath   EGO 아이템의 이미지 경로입니다.
 * @param onTap       아이템을 탭했을 때 호출되는 콜백 함수입니다.
 * @param isMoreBtn   '더보기' 버튼인지 여부를 나타냅니다. (기본값: false)
 * @param radius      아이템의 테두리 반지름입니다. (기본값: 28)
 */
Widget buildEgoListItem(
  Uint8List? profileImageBytes,
  VoidCallback onTap, {
  bool isMoreBtn = false,
  double radius = 28,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius.r,
        backgroundColor: isMoreBtn ? AppColors.gray300 : Colors.grey.shade300,
        backgroundImage:
            isMoreBtn
                ? null
                : profileImageBytes != null
                ? MemoryImage(profileImageBytes)
                : null,
        child:
            isMoreBtn
                ? Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.gray700,
                  size: 35,
                )
                : profileImageBytes == null
                ? Icon(Icons.person, color: Colors.white, size: radius.r)
                : null,
      ),
    ),
  );
}
