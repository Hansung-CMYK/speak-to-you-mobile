import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [StackAppBar]는 StackNavigation을 이용한 스크린에서 사용되는 AppBar이다.
///
/// '알림'과 '설정' 페이지 등 새로운 화면으로 이동 시 나타난다.
class StackAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 스크린의 이름이다.
  final String title;

  final String _backarrowPath = 'assets/icon/arrow_back.svg';

  /// [title] AppBar 중앙에 나타날 문구 주입 (스크린 명 권장). default: ""
  const StackAppBar({super.key, this.title = ""});

  /// 이전 페이지로 이동하는 함수이다.
  void backScreenMethod(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.w,
      ),
      child: AppBar(
        centerTitle: true, // AppBar의 제목 중앙 정렬
        surfaceTintColor: AppColors.white,
        leading: GestureDetector(
          onTap: () => backScreenMethod(context),
          child: Center(
            widthFactor: 24.w,
            heightFactor: 24.h,
            child: SvgPicture.asset(_backarrowPath),
          ),
        ),
        title: Text(
          // 페이지의 제목
          title,
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// AppBar의 사이즈 조정을 위한 필수 getter
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 12.h);
}
