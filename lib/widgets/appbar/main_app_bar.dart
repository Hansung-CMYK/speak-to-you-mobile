import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/color.dart';
import '../button/image_button.dart';

/// [MainAppBar]는 SpeakToYou에서 가장 기본적으로 사용되는 AppBar이다.
///
/// '스피크'와 '캘린더' 페이지를 TabBar를 통해 navigating 한다.
/// '알림'과 '설정' 페이지를 Button을 통해 navigating 한다.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// (임시) 에고 아이콘 이미지가 저장된 Path이다.
  final String egoIconPath = 'assets/image/ego_icon.png';
  final String notificationIconPath = 'assets/icon/notification.svg';

  /// [tabController]  선택한 Tab과 Body를 매핑하는 Controller이다.
  final TabController tabController;

  /// [tabController]  Tab과 body를 관리할 객체 주입
  const MainAppBar(this.tabController, {super.key});

  /// 페이지 이동 함수이다.
  void alertMethod(BuildContext context) {
    Navigator.pushNamed(context, 'Alert');
  }

  void settingsMethod(BuildContext context) {
    Navigator.pushNamed(context, 'Settings');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ), // 좌측 18px Padding을 준다.
      child: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.w,
        title: DefaultTabController(
          // TabBar를 AppBar의 좌측에 배치하기 위함
          length: tabController.length, // 이용할 Tab은 2개로 지정
          child: TabBar(
            controller: tabController,
            isScrollable:
                true, // TabBar의 너비를 지정할 수 있게 한다.(Default: Maximum Width)
            tabAlignment: TabAlignment
                .start, // TabBar의 Tab들을 왼쪽으로 정렬시킨다. (Default: Center)
            labelPadding: EdgeInsets.fromLTRB(0, 0, 16.w, 0), // 각 텍스트 간의 간격 지정
            indicator: BoxDecoration(), // 선택된 페이지의 밑줄 하이라이팅 제거
            dividerColor: AppColors.transparent, // TabBar의 영역 테두리를 제거
            overlayColor: WidgetStateProperty.all(
                Colors.transparent), // Tab 클릭 시 나타나는 Animation 제거
            labelStyle: TextStyle(
              // 선택된 Tab의 텍스트 속성
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              // 선택되지 않은 Tab의 텍스트 속성
              color: AppColors.gray400,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              // 지정된 Tab * 알림과 설정은 탭이 아닌 버튼을 통해 다른 페이지로 이동한다.
              Tab(text: "스피크"),
              Tab(text: "캘린더"),
            ],
          ),
        ),
        actions: [
          // '알림'과 '설정'을 AppBar의 우측에 배치하기 위한
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                // 알림 페이지로 이동하기 위한 Button
                icon: SvgPicture.asset(notificationIconPath),
                iconSize: 24.w,
                highlightColor: Colors.transparent, // 터치 애니메이션 제거
                onPressed: () => alertMethod(context),
                padding: EdgeInsets.zero,
              ), // TODO: 패딩이 0인데, 사이즈가 맞음... 수정 필요
              ImageButton(
                // 설정 페이지로 이동하기 위한 Button
                imagePath: egoIconPath,
                onTab: () => settingsMethod(context),
                width: 32.w,
                height: 32.h,
                radius: 56.r,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// AppBar의 사이즈 조정을 위한 필수 getter
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 12.h);
}
