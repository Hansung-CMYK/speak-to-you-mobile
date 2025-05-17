import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/button/svg_button.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:ego/theme/color.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'diary_view_screen.dart';

class DiaryEditScreen extends StatefulWidget {
  final List<Diary> diaries;

  const DiaryEditScreen({super.key, required this.diaries});

  @override
  State<DiaryEditScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends State<DiaryEditScreen> {
  @override
  Widget build(BuildContext context) {
    final diaries = widget.diaries;

    return Scaffold(
      appBar: StackAppBar(title: '일기수정'),
      body: Column(
        children: [
          // 스크롤 가능한 내용
          Expanded(
            child: RawScrollbar(
              thumbVisibility: true,
              thickness: 4.w,
              radius: Radius.circular(8.r),
              thumbColor: AppColors.gray700,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
                        child: Text(
                          diaries[0].date,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.strongOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ...diaries.map(
                          (diary) => _DiaryEditContainer(
                        context,
                        diary.title,
                        diary.content,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 하단에 고정된 '저장' 버튼
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20.h, right: 20.w, left: 20.w),
            child: TextButton(
              onPressed: () {
                // TODO 일기 저장
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                backgroundColor: AppColors.strongOrange,
              ),
              child: Text(
                "저장",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _DiaryEditContainer(
    BuildContext context,
    String subject,
    String content,
    ) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.gray200, width: 1.0.w),
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 24.h),
    child: Column(
      children: [
        // 주제
        Container(
          padding: EdgeInsets.only(bottom: 8.h),
          alignment: Alignment.centerLeft,
          child: Text(
            subject,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),

        // 내용
        Container(
          margin: EdgeInsets.only(bottom: 12.h),
          height: 96.h,
          child: RawScrollbar(
            thumbVisibility: true,
            thickness: 4.w,
            radius: Radius.circular(8.r),
            thumbColor: AppColors.gray700,
            child: SingleChildScrollView(
              child: TextField(
                controller: TextEditingController(text: content),
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        // 삭제 버튼
        GestureDetector(
          onTap: () {
            showConfirmDialog(
              context: context,
              title: '일기내용을 삭제할까요?',
              content: '삭제된 내용은 복원할 수 없습니다.',
              dialogType: DialogType.info,
              confirmText: '삭제',
              cancelText: '취소',
            );
          },
          child: Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gray200,
            ),
            child: Center(
              child: SvgButton(
                svgPath: 'assets/icon/trash_icon.svg',
                onTab: () {
                  showConfirmDialog(
                    context: context,
                    title: '일기내용을 삭제할까요?',
                    content: '삭제된 내용은 복원할 수 없습니다.',
                    dialogType: DialogType.info,
                    confirmText: '삭제',
                    cancelText: '취소',
                  );
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}