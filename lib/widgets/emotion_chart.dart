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
  // 초기 선택 상태는 없음
  int? _selectedIndex;
  final ScrollController _scrollController = ScrollController();

  // 1~31일의 데이터를 저장 (null이면 데이터 없음)
  late final List<double?> dailyData;

  @override
  void initState() {
    super.initState();
    final math.Random rand = math.Random();
    // 예시로 20% 확률로 데이터를 누락시키고, 나머지는 -1 ~ 1 범위의 난수값 생성
    dailyData = List.generate(31, (index) {
      return rand.nextDouble() < 0.2 ? null : rand.nextDouble() * 2 - 1;
    });
  }

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
    final double scaledDayWidth = dayWidth;
    final double scaledButtonSpacing = 16.w;
    // 한 버튼의 좌표 간격: 버튼 너비 + 패딩
    final double spacing = scaledDayWidth + scaledButtonSpacing;
    // 전체 콘텐츠 너비: 마지막 버튼의 오른쪽 끝까지
    final double totalWidth = (totalDays - 1) * spacing + scaledDayWidth;
    // 차트 하단 여백 (날짜 버튼 높이 + 추가 여백)
    final double chartBottomPadding = 27.h + 16.h;

    return Row(
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
        // 차트 영역
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(),
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
                          mainDataWithoutLeftTitles(
                            spacing,
                            totalWidth,
                            scaledButtonSpacing,
                          ),
                        ),
                      ),
                      // 날짜 버튼들 (하단 오버레이)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Row(
                          children: List.generate(totalDays, (index) {
                            bool isSelected = _selectedIndex == index;
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
                                        isSelected
                                            ? AppColors.primary
                                            : AppColors.gray100,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 3.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    double targetScrollOffset =
                                        (index - 3) * spacing;
                                    if (targetScrollOffset < 0) {
                                      targetScrollOffset = 0;
                                    }
                                    double maxScrollOffset =
                                        _scrollController
                                            .position
                                            .maxScrollExtent;
                                    if (targetScrollOffset > maxScrollOffset) {
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
                                          isSelected
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
    );
  }

  /// _selectedIndex가 null이거나 선택한 날짜의 데이터가 null이면 dot과 수직선을 표시하지 않습니다.
  LineChartData mainDataWithoutLeftTitles(
    double spacing,
    double totalWidth,
    double scaledButtonSpacing,
  ) {
    // 유효한 선택 여부 판단
    bool validSelected =
        _selectedIndex != null && dailyData[_selectedIndex!] != null;
    int validSelectedIndex = validSelected ? _selectedIndex! : -1;

    // 연속된 데이터 블록으로 나누어 선 생성
    List<LineChartBarData> lineBars = [];
    List<FlSpot> currentSegment = [];
    for (int i = 0; i < dailyData.length; i++) {
      double? value = dailyData[i];
      double xPos = i * spacing + 15.w;
      if (value != null) {
        currentSegment.add(FlSpot(xPos, value));
      } else {
        if (currentSegment.isNotEmpty) {
          lineBars.add(
            _buildLineChartBarData(
              currentSegment,
              validSelectedIndex,
              scaledButtonSpacing,
            ),
          );
          currentSegment = [];
        }
      }
    }
    if (currentSegment.isNotEmpty) {
      lineBars.add(
        _buildLineChartBarData(
          currentSegment,
          validSelectedIndex,
          scaledButtonSpacing,
        ),
      );
    }

    // 수직선: 유효한 선택일 때만 표시
    double selectedX = (_selectedIndex ?? 0) * spacing + 15.w;
    double? selectedY =
        (_selectedIndex != null) ? dailyData[_selectedIndex!] : null;
    LineChartBarData? verticalLine;
    if (validSelected) {
      verticalLine = LineChartBarData(
        isCurved: false,
        spots: [FlSpot(selectedX, -1), FlSpot(selectedX, selectedY!)],
        color: AppColors.accent,
        barWidth: 2.r,
        dotData: FlDotData(show: false),
      );
    }

    List<LineChartBarData> allBars = List.from(lineBars);
    if (verticalLine != null) allBars.add(verticalLine);

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        // 터치 이벤트에 의해 dot이 표시되지 않도록 모든 touched spot에 대해 null을 리턴
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((_) => null).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.transparent,
          getTooltipItems:
              (touchedSpots) => List.generate(touchedSpots.length, (_) => null),
        ),
      ),
      showingTooltipIndicators: [],
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
      lineBarsData: allBars,
    );
  }

  // 선을 생성하는 헬퍼 함수. validSelectedIndex가 -1이면 dot은 표시하지 않습니다.
  LineChartBarData _buildLineChartBarData(
    List<FlSpot> spots,
    int validSelectedIndex,
    double scaledButtonSpacing,
  ) {
    return LineChartBarData(
      isCurved: true,
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
          // 버튼 클릭으로 선택한 데이터의 x좌표와 일치할 때만 dot을 표시
          if (validSelectedIndex != -1 &&
              (spot.x -
                          (validSelectedIndex *
                                  (dayWidth + scaledButtonSpacing) +
                              15.w))
                      .abs() <
                  1e-3) {
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
  }
}
