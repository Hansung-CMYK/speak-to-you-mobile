import 'package:ego/models/diary/diary.dart';
import 'package:ego/screens/diary/topic_edit_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/theme/color.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopicEditScreen extends StatefulWidget {
  final Diary diary;

  const TopicEditScreen({super.key, required this.diary});

  @override
  State<TopicEditScreen> createState() => _TopicEditScreenState();
}

class _TopicEditScreenState extends State<TopicEditScreen> {
  @override
  Widget build(BuildContext context) {
    final diary = widget.diary;

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
                          diary.createdAt,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.strongOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ...diary.topics.map(
                      (topic) => TopicEditContainer(topic: topic),
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
                final updatedDiary = diary;

                Navigator.pop(context, updatedDiary);
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