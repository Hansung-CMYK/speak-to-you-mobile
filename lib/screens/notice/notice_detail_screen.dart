import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NoticeDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final DateTime date;

  const NoticeDetailScreen({super.key, required this.category, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ),
      child: Column(
        spacing: 24.h,
        children: [
          _title(),
          Divider(
            indent: 1,
            color: AppColors.gray200,
          ),
          _content(),
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(
          category,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          title,
          maxLines: 2,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          DateFormat('yyyy. MM. dd').format(date),
          style: TextStyle(
            color: AppColors.gray600,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _content() {
    return Text(
      SAMPLE_TEXT,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

String SAMPLE_TEXT = """
설 연휴 기간 동안 
[휴무 일정: 예시 - 2월 9일(금) ~ 2월 12일(월)] 운영이 중단되며, 
해당 기간 동안 접수된 문의는 
연휴 이후 순차적으로 처리될 예정입니다.

가족, 친지와 함께 행복한 명절 보내시고, 
새해에는 건강과 행운이 가득하시길 바랍니다. 
올 한 해도 많은 관심과 성원 부탁드립니다.

새해 복 많이 받으세요! 🎉🙏
""";