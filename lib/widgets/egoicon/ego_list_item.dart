import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildEgoListItem(String assetPath, VoidCallback onTap, {bool isMoreBtn = false, double radius = 28}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: isMoreBtn ? Color(0xFFA3A3A3) : null, // 더보기 버튼일 경우 회색 배경
        backgroundImage: isMoreBtn ? null : AssetImage(assetPath), // 더보기 버튼이 아니면 이미지 설정
        child: isMoreBtn
            ? Icon(
          Icons.more_horiz_rounded,
          color: Color(0xFF434242),
          size: 35,
        )
            : null,
      ),
    ),
  );
}
