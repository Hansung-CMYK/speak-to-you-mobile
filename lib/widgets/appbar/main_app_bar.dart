import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/color.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  void speakMethod() {

  }
  void calendarMethod() {

  }
  void settingsMethod() {
    
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparency,
      title: Row(
        children: [
          TextButton(onPressed: speakMethod, child: Text("스피크", style: TextStyle(color: AppColors.black, fontSize: 24, fontWeight: FontWeight.bold),)),
          TextButton(onPressed: calendarMethod, child: Text("캘린더", style: TextStyle(color: AppColors.gray400, fontSize: 24),)),
        ],
      ),
      actions: [
        TextButton(onPressed: calendarMethod, child: Text("알림", style: TextStyle(color: AppColors.gray400, fontSize: 24),)),
        IconButton(onPressed: settingsMethod, icon: Icon(Icons.person, size: 35.0,)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // AppBar의 기본 높이 설정
}

class SampleAppBarScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Text('Welcome to SampleMainAppBarScreen!'),
      ),
    );
  }
}
