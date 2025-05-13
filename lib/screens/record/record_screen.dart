import 'package:ego/screens/record/calendar/calendar_screen.dart';
import 'package:ego/screens/record/chart/chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color.dart';

/// 기록보기(가제) 화면이다. (2025-02-25: 현재는 캘린더 화면)
///
/// `캘린더`와 `감정차트`를 볼 수 있다.
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>
    with SingleTickerProviderStateMixin {
  /// [_tabController] `캘린더`와 `감정차트`를 선택하는 controller이다.
  late final TabController _tabController;

  /// _tabController 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// _tabController 제거
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // 탭 바와 화면 영역을 구분
      children: [
        _tabBar(), // 탭 바가 나타나는 영역이다.
        _tabBarView(), // 실질적이 화면이 나타나는 영역이다.
      ],
    );
  }

  /// 탭 바가 나타나는 영역이다.
  Widget _tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: TabBar(
        controller: _tabController, // 컨트롤러 부여
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: AppColors.gray400,
        dividerColor: AppColors.gray200, // 하단 분리선 색상
        overlayColor: WidgetStateProperty.all(
          Colors.transparent,
        ), // Tab 클릭 시 나타나는 Animation 제거
        indicatorColor: Colors.black, // 하단 하이라이팅
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.h),
        ), // 선택된 탭 하단 강조선 부여
        indicatorSize: TabBarIndicatorSize.tab, // 강조선 길이를 탭 길이로 연장
        tabs: [
          // 탭 종류
          Tab(text: "캘린더"),
          Tab(text: "감정차트"),
        ],
      ),
    );
  }

  /// 선택한 탭에 따라 다르게 보여지는 영역이다.
  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController, // 컨트롤러 부여
        children: [
          CalendarScreen(),
          ChartScreen(), // TODO: 감정차트
        ],
      ),
    );
  }
}