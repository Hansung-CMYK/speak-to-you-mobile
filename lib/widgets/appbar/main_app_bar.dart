import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color.dart';
import '../button/image_button.dart';

/// [MainAppBar]는 SpeakToYou에서 가장 기본적으로 사용되는 AppBar이다.
///
/// '스피크'와 '캘린더' 페이지를 TabBar를 통해 navigating 한다.
/// '알림'과 '설정' 페이지를 Button을 통해 navigating 한다.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// (임시) 에고 아이콘 이미지가 저장된 Path이다.
  final String egoIconPath = 'assets/image/egoIcon.png';

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
        toolbarHeight: kToolbarHeight + 12.h + 44.h, // 앱바 상단 영역 확장을 위한 길이 추가. 44.0px은 피그마 기준 휴대폰 알림창
        leadingWidth: double.maxFinite,
        leading: DefaultTabController(
          // TabBar를 AppBar의 좌측에 배치하기 위함
          length: tabController.length, // 이용할 Tab은 2개로 지정
          child: TabBar(
            controller: tabController,
            isScrollable:
                true, // TabBar의 너비를 지정할 수 있게 한다.(Default: Maximum Width)
            tabAlignment: TabAlignment
                .start, // TabBar의 Tab들을 왼쪽으로 정렬시킨다. (Default: Center)
            labelPadding:
                EdgeInsets.symmetric(horizontal: 8.w), // 각 텍스트 간의 간격 지정
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
            children: [
              IconButton(
                // 알림 페이지로 이동하기 위한 Button
                icon: Icon(Icons.alarm), // TODO: 디자인 확정되면 변경할 것
                iconSize: 32.w,
                highlightColor: Colors.transparent, // 터치 애니메이션 제거
                onPressed: () => alertMethod(context),
              ),
              ImageButton(
                // 설정 페이지로 이동하기 위한 Button
                imagePath: egoIconPath,
                onTab: () => settingsMethod(context),
                width: 32.w,
                height: 32.h,
                radius: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// AppBar의 사이즈 조정을 위한 필수 getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);
}
