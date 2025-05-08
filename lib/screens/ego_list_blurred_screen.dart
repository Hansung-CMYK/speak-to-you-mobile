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

  @override
  void initState() {
    super.initState();
    filteredList = List.from(widget.egoList);
  }

  // 검색 기능 구현
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [

          // Blur 효과
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Color.fromRGBO(136, 136, 136, 0.5),
            ),
          ),

          // SafeArea 내에서 검색창과 리스트를 세로로 배치
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
                        fontSize: 16.sp
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
