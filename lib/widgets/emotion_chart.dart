import 'dart:math' as math;

import 'package:ego/theme/color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmotionChart extends StatefulWidget {
  const EmotionChart({super.key});

  @override
  State<EmotionChart> createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  List<Color> gradientColors = [AppColors.primary, AppColors.accent];
  final double dayWidth = 31.w;
  int _selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final TextStyle leftLabelStyle = TextStyle(
    color: AppColors.gray600,
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
  );

  @override
  Widget build(BuildContext context) {
    final int totalDays = 31;
    // 버튼 너비와 버튼 사이 패딩
    final double scaledDayWidth = dayWidth.w;
    final double scaledButtonSpacing = 14.w;
    // 한 버튼의 좌표 간격: 버튼 너비 + 패딩
    final double spacing = scaledDayWidth + scaledButtonSpacing;
    // 전체 콘텐츠 너비: 마지막 버튼의 오른쪽 끝까지
    final double totalWidth = (totalDays - 1) * spacing + scaledDayWidth;
    // 차트 하단 여백 (날짜 버튼 높이 + 추가 여백)
    final double chartBottomPadding = 27.h + 16.h;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 왼쪽 라벨 영역 (긍정, 보통, 부정)
          Container(
            height: 172.h,
            padding: EdgeInsets.only(top: 16.h, bottom: 34.h, right: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('긍정', style: leftLabelStyle),
                Text('보통', style: leftLabelStyle),
                Text('부정', style: leftLabelStyle),
              ],
            ),
          ),
          // 차트 영역: Expanded로 감싸고 오른쪽에 20 패딩 추가
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: SizedBox(
                height: 172.h,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: totalWidth,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 24,
                            bottom: chartBottomPadding,
                          ),
                          child: LineChart(
                            duration: Duration(milliseconds: 0),
                            curve: Curves.easeOut,
                            mainDataWithoutLeftTitles(
                              totalDays,
                              spacing,
                              totalWidth,
                              _selectedIndex,
                            ),
                          ),
                        ),
                        // 날짜 버튼들: 차트 영역 하단에 오버레이
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Row(
                            children: List.generate(totalDays, (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      index == totalDays - 1
                                          ? 0
                                          : scaledButtonSpacing,
                                ),
                                child: SizedBox(
                                  width: scaledDayWidth,
                                  height: 27.h,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          index == _selectedIndex
                                              ? AppColors.primary
                                              : AppColors.gray100,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 3.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });

                                      // 선택된 버튼이 가운데(즉, 좌우로 3개씩 보이는 상태)가 되도록 오프셋 계산
                                      double targetScrollOffset =
                                          (index - 3) * spacing;
                                      // 좌측 경계를 벗어나지 않도록 보정
                                      if (targetScrollOffset < 0) {
                                        targetScrollOffset = 0;
                                      }

                                      double maxScrollOffset =
                                          _scrollController
                                              .position
                                              .maxScrollExtent;
                                      // 우측 경계를 벗어나지 않도록 보정
                                      if (targetScrollOffset >
                                          maxScrollOffset) {
                                        targetScrollOffset = maxScrollOffset;
                                      }

                                      _scrollController.animateTo(
                                        targetScrollOffset,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },

                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            index == _selectedIndex
                                                ? AppColors.white
                                                : AppColors.gray400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainDataWithoutLeftTitles(
    int totalDays,
    double spacing,
    double totalWidth,
    int selectedIndex,
  ) {
    // 데이터 포인트 생성 (x좌표에 15를 더해 중앙 정렬)
    List<FlSpot> spots = List.generate(
      totalDays,
      (index) => FlSpot(index * spacing + 15.w, math.sin(index * math.pi / 15)),
    );

    // 메인 차트 선
    final lineChartBarData = LineChartBarData(
      spots: spots,
      gradient: LinearGradient(colors: gradientColors),
      barWidth: 2.r,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (
          FlSpot spot,
          double percent,
          LineChartBarData barData,
          int index,
        ) {
          if (index == selectedIndex) {
            return FlDotCirclePainter(radius: 6.r, color: AppColors.accent);
          }
          return FlDotCirclePainter(
            radius: 0,
            color: Colors.transparent,
            strokeWidth: 0,
            strokeColor: Colors.transparent,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors:
              gradientColors
                  .map((color) => color.withValues(alpha: 0.3))
                  .toList(),
        ),
      ),
    );

    // 선택된 날짜의 x좌표와 y값 계산
    double selectedX = selectedIndex * spacing + 15.w;
    double selectedY = math.sin(selectedIndex * math.pi / 15);

    // 선택된 날짜에 대한 수직선 (차트 하단(y = -1)부터 실제 y값까지)
    final verticalLine = LineChartBarData(
      spots: [FlSpot(selectedX, -1), FlSpot(selectedX, selectedY)],
      isCurved: false,
      color: AppColors.accent,
      barWidth: 2.r,
      dotData: FlDotData(show: false),
    );

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return _selectedIndex == index
                ? TouchedSpotIndicatorData(
                  FlLine(color: AppColors.accent, strokeWidth: 2),
                  FlDotData(
                    getDotPainter:
                        (spot, percent, barData, index) => FlDotCirclePainter(
                          radius: 6.r,
                          color: AppColors.accent,
                        ),
                  ),
                )
                : null;
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.transparent,
          getTooltipItems:
              (touchedSpots) => List.generate(touchedSpots.length, (_) => null),
        ),
      ),
      showingTooltipIndicators: [
        ShowingTooltipIndicators([
          LineBarSpot(
            lineChartBarData,
            0, // 메인 차트 선의 인덱스 (한 선만 있으므로 0)
            spots[selectedIndex],
          ),
        ]),
      ],
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine:
            (value) => FlLine(
              color: AppColors.gray300.withValues(alpha: 0.5),
              strokeWidth: 0.5.r,
            ),
      ),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(
        show: true,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.gray300.withValues(alpha: 0.5),
            style: BorderStyle.solid,
            width: 0.5.r,
          ),
        ),
      ),
      minX: 0,
      maxX: totalWidth,
      minY: -1,
      maxY: 1,
      // 메인 차트와 수직선을 함께 표시
      lineBarsData: [lineChartBarData, verticalLine],
    );
  }
}
