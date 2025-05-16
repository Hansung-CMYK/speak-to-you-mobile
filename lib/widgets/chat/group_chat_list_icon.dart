import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildGroupListItem(String imageAssetPath, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      radius: 28, // 원하는 크기 설정
      backgroundColor: Colors.transparent, // 필요시 배경색 설정
      child: ClipOval(
        child: Image.asset(
          imageAssetPath,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
