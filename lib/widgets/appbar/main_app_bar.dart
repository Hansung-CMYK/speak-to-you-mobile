import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/color.dart';
import '../../theme/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  String egoIconPath = 'assets/image/egoIcon.png';

  void speakMethod() {

  }
  void calendarMethod() {

  }
  void alertMethod() {
    
  }
  void settingsMethod() {

  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: DefaultTabController(
        length: 2,
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
          indicator: BoxDecoration(),
          labelStyle: TextStyle(
            color: AppColors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            color: AppColors.gray400,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: "스피크"),
            Tab(text: "캘린더"),
          ],
        )
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.alarm),
                iconSize: 30,
                onPressed: alertMethod,
              ),
              IconButton(
                icon: ImageIcon(Image.asset(egoIconPath, scale: 9.0,).image),
                iconSize: 30,
                onPressed: settingsMethod,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() {
  runApp(
    ProviderScope(
      child: MainAppBarTest(),
    ),
  );
}

class MainAppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: SampleMainAppBarScreen(),
    );
  }
}

class SampleMainAppBarScreen extends ConsumerWidget {
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