import 'dart:math';

import 'package:ego/theme/color.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 필터 선택 정보를 담는 클래스
class FilterSelection {
  final int index;
  final int count;
  FilterSelection({required this.index, required this.count});
}

class EmotionFilter extends StatefulWidget {
  final ValueChanged<FilterSelection> onFilterSelected;
  const EmotionFilter({super.key, required this.onFilterSelected});

  @override
  State<EmotionFilter> createState() => _EmotionFilterState();
}

class _EmotionFilterState extends State<EmotionFilter> {
  int selectedIndex = -1;
  late final List<int> fixedDataCounts; // 각 버튼에 고정될 숫자 목록

  @override
  void initState() {
    super.initState();
    // 5개의 버튼에 대해 0~14 사이의 랜덤 숫자 생성
    fixedDataCounts = List.generate(5, (_) => Random().nextInt(15));
  }

  Widget emotionButton(String activePath, String text, int index) {
    bool isSelected = selectedIndex == index;
    String assetPath =
        isSelected
            ? activePath
            : activePath.replaceFirst('.svg', '_inactive.svg');

    // 미리 생성한 fixedDataCounts의 값을 사용
    int dataCount = fixedDataCounts[index];

    return SizedBox(
      width: 54.w,
      height: 72.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SvgButton(
                svgPath: assetPath,
                onTab: () {
                  setState(() {
                    // 이미 선택되어 있으면 해제(-1), 아니면 해당 인덱스로 설정
                    selectedIndex = isSelected ? -1 : index;
                  });
                  // 선택된 인덱스와 해당 버튼의 숫자(선택 해제 시 0)를 부모에게 전달
                  widget.onFilterSelected(
                    FilterSelection(
                      index: selectedIndex,
                      count:
                          selectedIndex == -1
                              ? 0
                              : fixedDataCounts[selectedIndex],
                    ),
                  );
                },
              ),
              // 데이터 개수가 0이 아닐 때만 라벨 출력
              if (dataCount > 0)
                Positioned(
                  right: -2.5.w,
                  top: -6.h,
                  child: Container(
                    width: 22.w,
                    height: 13.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.r, color: AppColors.gray100),
                      color: const Color(0xFFFF4D4F),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Text(
                        dataCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          height: 1.1.h,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      height: 122.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(17.5.w, 20.h, 17.5.w, 0.h),
        child: Column(
          children: [
            Row(
              children: [
                emotionButton('assets/icon/emotion/anger.svg', '분노', 0),
                SizedBox(width: 12.w),
                emotionButton('assets/icon/emotion/sadness.svg', '슬픔', 1),
                SizedBox(width: 12.w),
                emotionButton('assets/icon/emotion/happiness.svg', '기쁨', 2),
                SizedBox(width: 12.w),
                emotionButton(
                  'assets/icon/emotion/disappointment.svg',
                  '실망',
                  3,
                ),
                SizedBox(width: 12.w),
                emotionButton('assets/icon/emotion/embarrassment.svg', '황당', 4),
              ],
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: 40.w,
              height: 4.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: ShapeDecoration(
                        color: AppColors.gray200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 24.w,
                      height: 4.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF454C53),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
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
