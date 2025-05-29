import 'dart:math' as math;

import 'package:ego/services/ego/ego_service.dart';
import 'package:ego/utils/util_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';

import '../theme/color.dart';

class RelationBarScreen extends ConsumerStatefulWidget {
  RelationBarScreen({super.key});

  @override
  ConsumerState<RelationBarScreen> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends ConsumerState<RelationBarScreen> {

  List<BarData>? fetchedEgoToBarData;

  @override
  void initState() {
    super.initState();

    _fetchEgoRelationData();
  }

  void _fetchEgoRelationData() async {
    final fetchedEgoRelationData = await EgoService.fetchEgoRelation();

    setState(() {
      fetchedEgoToBarData = UtilFunction.relationDataToBarData(fetchedEgoRelationData);
    });

  }

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

  Set<String> selectedEmotions = {
    '부정적', '불안한', '지루한', '원만한', '만족한', '즐거운', '매력적'
  };

  final Map<int, String> emotionLabels = {
    2: '부정적',
    4: '불안한',
    6: '지루한',
    8: '원만한',
    10: '만족한',
    12: '즐거운',
    14: '매력적',
  };

  @override
  Widget build(BuildContext context) {
    if (fetchedEgoToBarData == null) {
      return const Center(child: CircularProgressIndicator()); // 로딩 표시
    }

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
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
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        // 숫자 -> 문자열 매핑
                        String? label;
                        if (value == 2) {
                          label = '부정적';
                        } else if (value == 4) {
                          label = '불안한';
                        } else if (value == 6) {
                          label = '지루한';
                        } else if (value == 8) {
                          label = '원만한';
                        } else if (value == 10) {
                          label = '만족한';
                        } else if(value == 12) {
                          label = '즐거운';
                        } else if(value == 14) {
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
                            color: fetchedEgoToBarData![index].color,
                            isSelected: touchedGroupIndex == index,
                            profileImage: fetchedEgoToBarData![index].profileImage,
                            egoName: fetchedEgoToBarData![index].name,
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
                  drawHorizontalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.darkCharcoal,
                    strokeWidth: 1,
                  ),
                ),
                barGroups: fetchedEgoToBarData!.asMap().entries
                    .where((entry) {
                  // 감정 필터링
                  final emotionLabel = emotionLabels[entry.value.value.toInt()];
                  return selectedEmotions.contains(emotionLabel);
                })
                    .map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  return generateBarGroup(index, data.color, data.value);
                }).toList(),
                maxY: 16,
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

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center ,
            children: [
              '부정적', '불안한', '지루한', '원만한',
              '만족한', '즐거운', '매력적',
            ].map((emotion) {
              final isSelected = selectedEmotions.contains(emotion);
              return ChoiceChip(
                label: Text(
                  emotion,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.gray900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedEmotions.add(emotion);
                    } else {
                      selectedEmotions.remove(emotion);
                    }
                  });
                },
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.gray200,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class BarData {
  const BarData(this.color, this.value, this.profileImage, this.name);

  final Color color;
  final double value;
  final Uint8List? profileImage;
  final String name;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
    required this.profileImage,
    required this.egoName
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;
  final Uint8List? profileImage;
  final String egoName;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
          (value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;

    final imageOrIcon = widget.profileImage != null
        ? ClipOval(
      child: Image.memory(
        widget.profileImage!,
        width: 28,
        height: 28,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.face,
            color: widget.color,
            size: 28,
          );
        },
      ),
    )
        : Icon(
      Icons.face,
      color: widget.color,
      size: 28,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform(
          transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
          origin: const Offset(14, 14),
          child: imageOrIcon,
        ),
        const SizedBox(height: 4),
        Text(
          '${widget.egoName}', // 혹은 다른 텍스트로 교체 가능
          style: TextStyle(
            fontSize: 10,
            color: widget.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
