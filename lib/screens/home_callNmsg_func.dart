import 'package:ego/widgets/appbar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/ego_info_model.dart';
import '../theme/color.dart';

class HomeScreenCallnMsg extends ConsumerStatefulWidget {
  final List<EgoInfoModel> egoList;

  const HomeScreenCallnMsg({super.key, required this.egoList});

  @override
  HomeChatScreenState createState() => HomeChatScreenState();
}

class HomeChatScreenState extends ConsumerState<HomeScreenCallnMsg>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;
  late final List<EgoInfoModel> egoList;
  late EgoInfoModel selectedEgo; // 전택된 EGO의 정보

  /// _tabCntroller 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    egoList = widget.egoList;
    selectedEgo = egoList.first;
  }

  /// _tabCntroller 제거
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(_tabController),
      body: Column(
        children: [
          // 상단 스토리 EGO 리스트
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: SizedBox(
              height: 80.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                children:
                    egoList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final ego = entry.value;

                      return index == 0
                          ? _buildAvatarWithGradient(ego.egoIcon, () => setState(() => selectedEgo = ego))
                          : _buildAvatar(ego.egoIcon, () => setState(() => selectedEgo = ego));
                    }).toList(),
              ),
            ),
          ),

          // TODO 여기서 EGO가 움직입니다.
          Expanded(
            child: Container(
              color: Colors.green.withOpacity(0.3), // 영역 표시용 배경색
              child: Center(
                child: Container(
                  child: Image.asset(
                    'assets/image/ego_1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // 현재 EGO 카드
          _buildSelectedEGO(),
        ],
      ),
    );
  }

  // 현재 Ego의 정보 Card
  Widget _buildSelectedEGO() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '현재 EGO',
                  style: TextStyle(
                    color: AppColors.gray600,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  selectedEgo.egoName,
                  style: TextStyle(
                    color: AppColors.gray900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            _buildAvatar(selectedEgo.egoIcon, () {}), // 클릭 없음
          ],
        ),
      ),
    );
  }
}

// Ego 사진
Widget _buildAvatar(String assetPath, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: GestureDetector(
      onTap: onTap,
      child: CircleAvatar(backgroundImage: AssetImage(assetPath), radius: 28),
    ),
  );
}

// Gradient가 있는 EGO 사진
Widget _buildAvatarWithGradient(String assetPath, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment(1, 0),
              end: Alignment(-1, 0),
              colors: [
                AppColors.royalBlue,
                AppColors.amethystPurple,
                AppColors.softCoralPink,
                AppColors.vividOrange,
              ],
            ),
          ),
        ),
        Container(
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
        ),
        _buildAvatar(assetPath, onTap),
      ],
    ),
  );
}
