import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/color.dart';

Widget buildEmojiSendBtn({
  VoidCallback? onPressed,
  bool isPressed = false,
}) {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.all(10),
    child: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: isPressed
                  ? AppColors.accent.withOpacity(0.5) // 눌린 색
                  : AppColors.accent, // 기본 색
              child: IconButton(
                icon: SvgPicture.asset("assets/icon/emoji_send_btn.svg"),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
