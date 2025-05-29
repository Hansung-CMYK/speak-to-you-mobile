import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color.dart';

class RelationBarScreen extends ConsumerStatefulWidget {
  RelationBarScreen({super.key});

  final dataList = [
    const _BarData(AppColors.amethystPurple, 18),
    const _BarData(AppColors.naverColor, 17),
    const _BarData(AppColors.primary, 10),
    const _BarData(AppColors.strongOrange, 2.5),
    const _BarData(AppColors.accent, 2),
    const _BarData(AppColors.warningBase, 2),
  ];

  @override
  ConsumerState<RelationBarScreen> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends ConsumerState<RelationBarScreen> {
  BarChartGroupData generateBarGroup(
      int x,
      Color color,
      double value,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int rotationTurns = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 18),
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                rotationQuarterTurns: rotationTurns,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: AppColors.deepPrimary,
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      interval: 2.0,
                      getTitlesWidget: (value, meta) {
                        // 숫자 -> 문자열 매핑
                        String? label;
                        if (value == 2) {
                          label = '부정적';
                        } else if (value == 6) {
                          label = '불안한';
                        } else if (value == 10) {
                          label = '지루한';
                        } else if (value == 14) {
                          label = '원만한';
                        } else if (value == 18) {
                          label = '만족한';
                        } else if(value == 24) {
                          label = '즐거운';
                        } else if(value == 28) {
                          label = '매력적';
                        }

                        if (label == null) return const SizedBox.shrink();

                        return Container(margin: EdgeInsets.only(right: 6.h), child: SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Transform.rotate(
                            angle: -0.5, // 라디안 단위: 음수는 왼쪽으로 기울기, 양수는 오른쪽
                            child: Text(
                              label,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.gray900,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ));
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return SideTitleWidget(
                          meta: meta,
                          child: _IconWidget(
                            color: widget.dataList[index].color,
                            isSelected: touchedGroupIndex == index,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.darkCharcoal,
                    strokeWidth: 1,
                  ),
                ),
                barGroups: widget.dataList.asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                    index,
                    data.color,
                    data.value
                  );
                }).toList(),
                maxY: 20,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipMargin: 0,
                    getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                        ) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: rod.color,
                          fontSize: 18,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      setState(() {
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      });
                    } else {
                      setState(() {
                        touchedGroupIndex = -1;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value);

  final Color color;
  final double value;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
          (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}