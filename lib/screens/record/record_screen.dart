import 'package:ego/screens/record/calendar/calendar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color.dart';
import 'chart/tmp_chart_screen.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// _tabCntroller 제거
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tabBar(),
        _tabBarView(),
      ],
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TabBar( //TODO: 패딩 주기
        controller: _tabController,
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: AppColors.gray400,
        dividerColor: AppColors.gray200, // 하단 분리선 색상
        overlayColor: WidgetStateProperty.all(Colors.transparent), // Tab 클릭 시 나타나는 Animation 제거
        indicatorColor: Colors.black, // 하단 하이라이팅
        indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 2.h)),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: "캘린더"),
          Tab(text: "감정차트"),
        ],
      ),
    );
  }

  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
            CalendarScreen(),
            TmpChartScreen(), // TODO: 감정차트
        ],
      ),
    );
  }
}