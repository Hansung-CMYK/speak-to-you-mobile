import 'dart:math';

import 'package:ego/theme/color.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 필터 선택 정보를 담는 클래스
class FilterSelection {
  final int index;

  FilterSelection({required this.index});
}

class RelationFilter extends StatefulWidget {
  final ValueChanged<FilterSelection> onFilterSelected;

  const RelationFilter({super.key, required this.onFilterSelected});

  @override
  State<RelationFilter> createState() => _RelationFilterState();
}

class _RelationFilterState extends State<RelationFilter> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Widget emotionButton(String activePath, String text, int index) {
    bool isSelected = selectedIndex == index;
    String assetPath =
        isSelected
            ? activePath
            : activePath.replaceFirst('.svg', '_inactive.svg');

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
                    ),
                  );
                },
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
                emotionButton('assets/icon/emotion/anger.svg', '배드민턴', 0),
                SizedBox(width: 12.w),
                emotionButton('assets/icon/emotion/sadness.svg', '활발한', 1),
                SizedBox(width: 12.w),
                emotionButton('assets/icon/emotion/happiness.svg', '영화중독', 2),
                SizedBox(width: 12.w),
                emotionButton(
                  'assets/icon/emotion/disappointment.svg',
                  '게이머',
                  3,
                ),
                SizedBox(width: 12.w),
                emotionButton(
                  'assets/icon/emotion/embarrassment.svg',
                  '맛집러버',
                  4,
                ),
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
