import 'dart:ui';
import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/egoicon/ego_list_item.dart';

class BlurredListScreen extends StatefulWidget {
  final List<EgoInfoModel> egoList;
  final void Function(EgoInfoModel) onEgoSelected;

  const BlurredListScreen({
    super.key,
    required this.egoList,
    required this.onEgoSelected,
  });

  @override
  State<BlurredListScreen> createState() => _BlurredListScreenState();
}

class _BlurredListScreenState extends State<BlurredListScreen> {
  late List<EgoInfoModel> filteredList;
  String searchQuery = '';
  String selectedSort = '최신대화순';

  final List<String> sortOptions = ['최신대화순', '이름순'];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(widget.egoList);
  }

  void _filterList(String query) {
    setState(() {
      searchQuery = query;
      filteredList =
          widget.egoList
              .where(
                (ego) =>
                    ego.egoName.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      _applySort(); // 필터 후 정렬도 적용
    });
  }

  void _selectSort(String sort) {
    setState(() {
      selectedSort = sort;
      _applySort();
    });
  }

  void _applySort() {
    // 먼저 검색어에 맞게 필터링
    filteredList =
        widget.egoList
            .where(
              (ego) =>
                  ego.egoName.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    // 그런 다음 정렬 적용
    if (selectedSort == '이름순') {
      filteredList.sort((a, b) => a.egoName.compareTo(b.egoName));
    }
  }

  Widget _buildSortButton(String option) {
    final isSelected = selectedSort == option;
    return GestureDetector(
      onTap: () => _selectSort(option),
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6975FB) : AppColors.unfilterBtn,
          border: Border.all(
            color: isSelected ? Color(0xFF6975FB) : AppColors.unfilterBtn,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          option,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [
          // 투명한 배경
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Color.fromRGBO(136, 136, 136, 0.5)),
          ),

          // List 몸통
          SafeArea(
            child: Column(
              children: [
                // 검색창
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: TextField(
                    onChanged: _filterList,
                    decoration: InputDecoration(
                      hintText: 'EGO 이름을 입력하세요',
                      hintStyle: TextStyle(
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      prefixIcon: Icon(Icons.search, color: AppColors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.gray200),
                      ),
                    ),
                  ),
                ),

                // 정렬 버튼
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children:
                              sortOptions
                                  .map((option) => _buildSortButton(option))
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                // 리스트
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final ego = filteredList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.only(left: 3.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.gray200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            ego.egoName,
                            style: TextStyle(
                              color: AppColors.gray900,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: buildEgoListItem(
                            ego.egoIcon,
                            () {},
                            radius: 19,
                          ),
                          onTap: () {
                            widget.onEgoSelected(ego);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
