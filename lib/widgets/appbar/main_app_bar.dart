import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/color.dart';
import '../button/image_button.dart';

/// [MainAppBar]는 SpeakToYou에서 가장 기본적으로 사용되는 AppBar이다.
///
/// '스피크'와 '캘린더' 페이지를 TabBar를 통해 navigating 한다.
/// '알림'과 '설정' 페이지를 Button을 통해 navigating 한다.
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController tabController;

  const MainAppBar(this.tabController, {super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 12.h);

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    fetchUnreadCount(); // API 호출
  }

  Future<void> fetchUnreadCount() async {
    // TODO: 사용자가 읽지 않은 알림 수 받아오기
    int count = 5; // 예시: 받아온 알림 개수
    setState(() {
      unreadCount = count;
    });
  }

  void alertMethod(BuildContext context) {
    Navigator.pushNamed(context, '/alert');
  }

  void settingsMethod(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.white,
        titleSpacing: 0.w,
        title: DefaultTabController(
          length: widget.tabController.length,
          child: TabBar(
            controller: widget.tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
            indicator: BoxDecoration(),
            dividerColor: AppColors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelStyle: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: AppColors.gray400,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            tabs: [Tab(text: "스피크"), Tab(text: "캘린더"), Tab(text: "채팅방")],
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // 알림 아이콘
                  Container(
                    width: 24.w,
                    height: 24.h,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icon/notification.svg',
                        fit: BoxFit.cover,
                      ),
                      highlightColor: Colors.transparent,
                      onPressed: () => alertMethod(context),
                      padding: EdgeInsets.zero,
                    ),
                  ),

                  // 알림 배지 (unreadCount > 0일 때만 표시)
                  if (unreadCount > 0)
                    Positioned(
                      left: 10, // 아이콘의 오른쪽 위로 위치
                      bottom: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16.w,
                          minHeight: 16.h,
                        ),
                        child: Text(
                          '$unreadCount',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: ImageButton(
                  imagePath: 'assets/image/ego_icon.png',
                  onTab: () => settingsMethod(context),
                  width: 32.w,
                  height: 32.h,
                  radius: 56.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
