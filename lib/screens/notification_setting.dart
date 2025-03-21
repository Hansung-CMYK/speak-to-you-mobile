import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Scaffold(
              appBar: StackAppBar(title: '알림 설정'),
              body: NotificationSetting(),
            ),
          ),
    );
  }
}

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationSetting> {
  bool isToggled1 = false;
  bool isToggled2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        children: [
          _buildNotificationItem(
            title: "푸시 알림",
            description: "이벤트나 공지사항을 알려줄게요!",
            value: isToggled1,
            onChanged: (value) {
              setState(() {
                isToggled1 = value;
              });
            },
          ),
          SizedBox(height: 24.h),
          _buildNotificationItem(
            title: "깨비 톡톡",
            description: "하루 중 아무 때나, 말을 걸어 줄게요",
            value: isToggled2,
            onChanged: (value) {
              setState(() {
                isToggled2 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(fontSize: 14.sp, color: AppColors.gray600),
              ),
            ],
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.primary,
        ),
      ],
    );
  }
}
