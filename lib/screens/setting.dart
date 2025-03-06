import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title('계정 관리'),
          // 기본: 오른쪽 화살표 아이콘 (기본값)
          content('개인정보 보호', () {}),
          // 아무것도 없는 trailing widget
          content('에고 수정', () {
            // Navigator.push(
            //   context,
            //   // MaterialPageRoute(builder: (_) => 수정 페이지),
            // );
          }),
          // 초기화 버튼 Container 사용
          content('비밀번호 초기화', () {
            // 비밀번호 초기화 페이지 이동 또는 팝업 호출
          }),
          // 기본 trailing widget (오른쪽 화살표 아이콘)
          content('알림설정', () {
            // 알림설정 페이지 이동
          }),
          divider(),
          title('정보'),
          content('공지사항', () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (_) => NoticePage()),
            // );
          }),
          content('문의하기', () {
            // 문의하기 팝업 또는 페이지 이동
          }),
          content('이용약관', () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (_) => TermsOfServicePage()),
            // );
          }),
          divider(),
          title('앱 관리'),
          content('앱 버전(v1.2.5 )', () {
            showConfirmDialog(context: context, title: '안녕');
          }),
          content(
            'EGO 초기화',
            () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => InquiryPage()),
              // );
            },
            trailingWidget: Container(
              width: 48,
              height: 26,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: ShapeDecoration(
                color: Color(0xFFE8EBED),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  '초기화',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF72787F),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                    letterSpacing: -0.60,
                  ),
                ),
              ),
            ),
          ),
          divider(),
          // 텍스트 색상과 굵기를 지정하는 예시
          content('로그아웃', () {
            showConfirmDialog(
              context: context,
              title: '로그아웃 하시겠어요?',
              dialogType: DialogType.info,
            );
          }),
          content(
            '탈퇴하기',
            () {
              showConfirmDialog(
                context: context,
                title: '탈퇴 하시겠어요?',
                dialogType: DialogType.info,
              );
            },
            textColor: Colors.red,
            bold: true,
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
      child: SizedBox(
        height: 1.h,
        child: Row(
          children: [Expanded(child: Container(color: AppColors.gray200))],
        ),
      ),
    );
  }

  Widget title(String text) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.h, left: 20.w, right: 20.w),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  // textColor와 bold 파라미터를 추가한 content 함수
  Widget content(
    String text,
    VoidCallback onTap, {
    Widget? trailingWidget,
    Color? textColor,
    bool bold = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                  color: textColor ?? AppColors.black,
                ),
              ),
            ),
            trailingWidget ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: AppColors.gray600,
                ),
          ],
        ),
      ),
    );
  }
}
