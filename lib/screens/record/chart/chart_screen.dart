import 'package:ego/theme/color.dart';
import 'package:ego/widgets/calendar_indicator.dart';
import 'package:ego/widgets/diary_section.dart';
import 'package:ego/widgets/emotion_chart.dart';
import 'package:ego/widgets/emotion_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TmpChartScreen extends StatefulWidget {
  const TmpChartScreen({super.key});

  @override
  State<TmpChartScreen> createState() => _TmpChartScreenState();
}

class _TmpChartScreenState extends State<TmpChartScreen> {
  // FilterSelection: index와 버튼에 표시된 숫자 정보를 함께 저장 (null 또는 index == -1이면 미선택)
  FilterSelection? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 17.h, left: 20.w, right: 20.w),
                child: Column(children: [CalendarIndicator(), EmotionChart()]),
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
                  SizedBox(height: 12.h),
                  // 필터 버튼 미선택 또는 해제된 경우 안내 메시지 표시
                  if (selectedFilter == null || selectedFilter!.index == -1)
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Text(
                        '필터 버튼을 선택해주세요!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray300,
                        ),
                      ),
                    )
                  else
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
