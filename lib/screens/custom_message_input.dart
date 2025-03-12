import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ego/theme/color.dart';

class CustomMessageInput extends StatelessWidget {
  final bool isVisible;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSend;

  const CustomMessageInput({
    super.key,
    required this.isVisible,
    required this.controller,
    required this.focusNode,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      bottom: isVisible ? keyboardHeight : -100.h,
      left: 0,
      right: 0,
      child:
          isVisible
              ? ScreenUtilInit(
                designSize: Size(393, 852),
                builder: (context, child) => _buildInputField(context),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Container(
      width: 353.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 4.h,
              left: 16.w,
              right: 4.w,
              bottom: 4.h,
            ),
            decoration: ShapeDecoration(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: AppColors.gray200),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            constraints: BoxConstraints(
              minHeight: 30.h, // 최소 높이 설정
              maxHeight: 100.h, // 최대 높이 설정
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    focusNode: focusNode,
                    maxLines: null,
                    // 자동 줄바꿈 허용
                    minLines: 1,
                    // 최소 한 줄 유지
                    decoration: InputDecoration(
                      hintText: '메세지를 입력하세요...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.gray700,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.8,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.gray900,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.8.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.text.trim().isNotEmpty) {
                      onSend(controller.text);
                      controller.clear();
                    }
                  },
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: ShapeDecoration(
                      color: AppColors.royalBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icon/paper_plane.svg',
                        width: 20.w,
                        height: 20.h,
                        fit: BoxFit.contain,
                      ),
                    ),
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
