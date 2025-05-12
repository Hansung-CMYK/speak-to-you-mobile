import 'dart:ui';
import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/chat/chat_room_model.dart';
import '../models/ego_model.dart';
import '../services/chat/chat_room_service.dart';
import '../services/ego/ego_service.dart';
import '../widgets/egoicon/ego_list_item.dart';

class BlurredListScreen extends ConsumerStatefulWidget {
  final String uid;
  final void Function(EgoModel) onEgoSelected;

  const BlurredListScreen({
    super.key,
    required this.uid,
    required this.onEgoSelected,
  });

  @override
  ConsumerState<BlurredListScreen> createState() => _BlurredListScreenState();
}

class _BlurredListScreenState extends ConsumerState<BlurredListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ChatRoomModel> _chatRooms = [];
  final List<EgoModel> _egoList = [];
  late List<EgoModel> filteredList = [];

  String searchQuery = '';
  String selectedSort = '최신대화순';

  final List<String> sortOptions = ['최신대화순', '이름순', '평점순', '하트 많은 순'];

  int _pageNum = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchMoreData();
      }
    });
  }

  Future<void> _fetchInitialData() async {
    setState(() => _isLoading = true);
    final chatRooms = await ChatRoomService.fetchChatRoomList(
      uid: widget.uid,
      pageNum: _pageNum,
      pageSize: 11,
    );
    if (chatRooms.isEmpty) {
      setState(() => _hasMore = false);
    } else {
      final egos = await EgoService.fetchEgoModelsForChatRooms(chatRooms, ref);
      setState(() {
        _chatRooms.addAll(chatRooms);
        _egoList.addAll(egos);
        filteredList = List.from(_egoList);
        _applySort(); // 정렬 적용
        _pageNum++;
      });
    }
    setState(() => _isLoading = false);
  }

  Future<void> _fetchMoreData() async {
    setState(() => _isLoading = true);
    final chatRooms = await ChatRoomService.fetchChatRoomList(
      uid: widget.uid,
      pageNum: _pageNum,
      pageSize: 11,
    );
    if (chatRooms.isEmpty) {
      setState(() => _hasMore = false);
    } else {
      final egos = await EgoService.fetchEgoModelsForChatRooms(chatRooms, ref);
      setState(() {
        _chatRooms.addAll(chatRooms);
        _egoList.addAll(egos);
        _applyFilterAndSort(); // 필터 + 정렬 적용
        _pageNum++;
      });
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _filterList(String query) {
    setState(() {
      searchQuery = query;
      _applyFilterAndSort();
    });
  }

  void _selectSort(String sort) {
    setState(() {
      selectedSort = sort;
      _applySort();
    });
  }

  void _applyFilterAndSort() {
    filteredList = _egoList
        .where((ego) =>
        ego.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    _applySort();
  }

  void _applySort() {
    switch (selectedSort) {
      case '이름순':
        filteredList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case '최신대화순':
        filteredList = List.from(_egoList);
        break;
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      right: 16.h,
                      left: 16.h,
                      bottom: 5.h,
                    ),
                    child: Row(
                      children:
                          sortOptions
                              .map((option) => _buildSortButton(option))
                              .toList(),
                    ),
                  ),
                ),

                // 리스트
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: filteredList.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == filteredList.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

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
                            ego.name,
                            style: TextStyle(
                              color: AppColors.gray900,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text('4', style: TextStyle(fontSize: 14.sp)),
                                ],
                              ),
                              SizedBox(width: 8.w),
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: AppColors.strongOrange,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '123',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w),
                              buildEgoListItem(
                                ego.profileImage,
                                () {},
                                radius: 19,
                              ),
                            ],
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
