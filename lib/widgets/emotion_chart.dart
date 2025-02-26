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
  final double dayWidth = 50.0;

  // 단일 ScrollController 생성 (차트와 버튼 영역에 공유)
  final ScrollController _scrollController = ScrollController();

  List<FlSpot> get spots {
    return List.generate(
      31,
      (index) => FlSpot(
        index.toDouble(),
        math.sin(index * math.pi / 15), // -1 ~ 1 사이 값
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 왼쪽 라벨에 사용할 텍스트 스타일
  final TextStyle leftLabelStyle = TextStyle(
    color: AppColors.gray600,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // 차트와 왼쪽 라벨 영역
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 왼쪽 라벨 영역 (긍정, 보통, 부정)
              Container(
                height: 172.h,
                padding: EdgeInsets.only(top: 16.h, bottom: 24.h, right: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('긍정', style: leftLabelStyle),
                    Text('보통', style: leftLabelStyle),
                    Text('부정', style: leftLabelStyle),
                  ],
                ),
              ),
              // 스크롤 가능한 차트 영역
              SizedBox(
                width: dayWidth * 7, // 한 번에 7일치만 보여주기 위한 뷰포트
                height: 172.h,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: dayWidth * 31, // 전체 31일치 데이터
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: LineChart(mainDataWithoutLeftTitles()),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // 날짜 버튼 영역 (차트와 동일한 ScrollController 사용)
          SizedBox(
            height: 50,
            width: dayWidth * 7, // 뷰포트 크기를 동일하게 맞춤
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(31, (index) {
                  return Container(
                    width: dayWidth,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    child: ElevatedButton(
                      onPressed: () {
                        // 버튼 클릭 시 해당 날짜의 시작 위치로 스크롤 (예: index * dayWidth)
                        _scrollController.animateTo(
                          index * dayWidth,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('${index + 1}'),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 예제에서는 차트 내부의 하단 타이틀은 사용하지 않으므로,
  // 별도의 leftTitles와 bottomTitles는 빈 위젯으로 처리합니다.
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return Container();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Container();
  }

  // 차트 데이터 구성 (뷰포트는 0~6, 실제 데이터는 0~30)
  LineChartData mainDataWithoutLeftTitles() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(color: AppColors.accent, strokeWidth: 2),
              FlDotData(
                getDotPainter:
                    (spot, percent, barData, index) =>
                        FlDotCirclePainter(radius: 6, color: AppColors.accent),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.transparent,
          getTooltipItems:
              (touchedSpots) => List.generate(touchedSpots.length, (_) => null),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine:
            (value) => FlLine(
              color: AppColors.gray300.withOpacity(0.5),
              strokeWidth: 0.5,
            ),
      ),
      titlesData: FlTitlesData(
        show: false, // 차트 내부 타이틀은 모두 숨김
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.gray300.withOpacity(0.5),
            style: BorderStyle.solid,
            width: 0.5,
          ),
        ),
      ),
      // 뷰포트: 0~6 (7일치)
      minX: 0,
      maxX: 6,
      minY: -1,
      maxY: 1,
      lineBarsData: [
        LineChartBarData(
          // 예시 데이터 (실제 spots 데이터와 연결 가능)
          spots: [
            FlSpot(0, -0.2),
            FlSpot(1, -0.3),
            FlSpot(2, -0.2),
            FlSpot(3, 0.0),
            FlSpot(4, -0.1),
            FlSpot(5, 0.0),
            FlSpot(6, 1),
          ],
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
