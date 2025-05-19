import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ego/models/diary/diary.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';

class TopicEditContainer extends StatefulWidget {
  final Topic topic;

  const TopicEditContainer({Key? key, required this.topic}) : super(key: key);

  @override
  State<TopicEditContainer> createState() => _TopicEditContainerState();
}

class _TopicEditContainerState extends State<TopicEditContainer> {
  late final TextEditingController _contentController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.topic.content);
    _contentController.addListener(() {
      widget.topic.content = _contentController.text;
    });
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;

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
              topic.title,
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
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 4.w,
              radius: Radius.circular(8.r),
              thumbColor: AppColors.gray700,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: TextField(
                  controller: _contentController,
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
            onTap: () async {
              var dialogRes = await showConfirmDialog(
                context: context,
                title: topic.isDeleted! ? '해당 토픽을 복원할까요?': '해당 토픽을 삭제할까요?',
                content: topic.isDeleted! ? '토픽이 일기에 다시 추가됩니다.': null,
                dialogType: DialogType.info,
                confirmText: topic.isDeleted! ? '복원':'삭제',
                cancelText: '취소',
              );

              if (dialogRes == true) {
                setState(() {
                  topic.isDeleted = !(topic.isDeleted!);
                });
              }
            },
            // 삭제 된 경우 icon색상을 흰색에 빨간 배경, 아닌 경우 icon색상을 회색
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: topic.isDeleted! ? Colors.red : AppColors.gray200,
              ),
              child: Center(
                child: SvgPicture.asset( topic.isDeleted! ? 'assets/icon/trash_enabled.svg' : 'assets/icon/trash_icon.svg' ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
