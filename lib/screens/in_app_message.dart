import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import '../theme/color.dart';

void showFlushBarFromForeground(RemoteMessage message) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  Flushbar(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(24),
    borderColor: AppColors.gray400,
    margin: EdgeInsets.all(16),
    flushbarPosition: FlushbarPosition.TOP,
    isDismissible: true,
    // 수동 닫기 활성화
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // 좌우 슬라이드로만 닫기
    messageText: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: SvgPicture.asset("assets/icon/fcm_pencil.svg"),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '일기 작성 시간이 되었어요! 같이 작성해볼까요?',
                    style: TextStyle(
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '오늘은 어떤 일기가 만들어질까요?',
                    style: TextStyle(color: AppColors.gray900, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),

        Container(
          margin: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.deepPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              print("눌림");
            },
            child: Text(
              '작성하기',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  ).show(context);
}
