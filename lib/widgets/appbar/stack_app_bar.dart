import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [StackAppBar]는 StackNavigation을 이용한 스크린에서 사용되는 AppBar이다.
///
/// '알림'과 '설정' 페이지 등 새로운 화면으로 이동 시 나타난다.
class StackAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 스크린의 이름이다.
  final String title;

  /// [title] AppBar 중앙에 나타날 문구 주입 (스크린 명 권장).
  const StackAppBar({super.key, required this.title});

  /// 이전 페이지로 이동하는 함수이다.
  void backScreenMethod(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.5.sp),
      child: AppBar(
        toolbarHeight: kToolbarHeight + 44.h, // 앱바 상단 영역 확장을 위한 70px 추가
        centerTitle: true, // AppBar의 제목 중앙 정렬
        leading: IconButton(
          // 뒤로가기 버튼
          onPressed: () => backScreenMethod(context),
          highlightColor: Colors.transparent, // 터치 애니메이션 제거
          icon: Icon(
            Icons.arrow_back, // 뒤로가기 아이콘 (안드로이드 버전)
            size: 24.w,
          ),
        ),
        title: Text(
          // 페이지의 제목
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// AppBar의 사이즈 조정을 위한 필수 getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);
}
