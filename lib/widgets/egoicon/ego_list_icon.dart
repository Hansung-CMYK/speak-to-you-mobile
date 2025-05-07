import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildEgoListItem(String assetPath, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(backgroundImage: AssetImage(assetPath), radius: 28),
    ),
  );
}
