import 'package:ego/theme/color.dart';
import 'package:ego/widgets/calendar_indicator.dart';
import 'package:ego/widgets/diary_section.dart';
import 'package:ego/widgets/emotion_chart.dart';
import 'package:ego/widgets/emotion_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../relation/ego_relation_screen.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  FilterSelection? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // EGO 관계 화면 부분
            Container(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 17.h, left: 20.w, right: 20.w),
                child: SizedBox(
                  height: 300.h,  // 적절한 높이로 제한
                  child: GraphWidget(),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  EmotionFilter(
                    onFilterSelected: (FilterSelection selection) {
                      setState(() {
                        selectedFilter = selection;
                      });
                    },
                  ),
                  if (selectedFilter != null && selectedFilter!.index != -1)
                    DiarySection(
                      filterIndex: selectedFilter!.index,
                      diaryCount: selectedFilter!.count,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
