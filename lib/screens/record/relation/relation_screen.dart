import 'package:ego/theme/color.dart';
import 'package:ego/widgets/relation_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/relation/ego_relation_widget.dart';

class RelationScreen extends StatefulWidget {
  const RelationScreen({super.key});

  @override
  State<RelationScreen> createState() => _RelationScreenState();
}

class _RelationScreenState extends State<RelationScreen> {
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
                  child: EgoRelationWidget(
                    filterSelection: selectedFilter ?? FilterSelection(index: -1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Filter 부분
                  RelationFilter(
                    onFilterSelected: (FilterSelection selection) {
                      setState(() {
                        selectedFilter = selection;
                      });
                    },
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
