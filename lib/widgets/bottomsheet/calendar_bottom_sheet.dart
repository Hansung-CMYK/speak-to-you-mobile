import 'package:ego/screens/diary/diary_view_for_bottom_sheet.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 일기보기(캘린더)에서 이용하는 BottomSheet이다.
///
/// 사용자의 일간 일기 카드 리스트가 나타난다.
/// TODO: 일기 카드에 길이가 적용되지 않는 문제있음. 일단 자체 Padding으로 해결
class CalendarBottomSheet extends StatefulWidget {
  final int diaryId;

  const CalendarBottomSheet({super.key, required this.diaryId});

  @override
  State<StatefulWidget> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {

  late int diaryId;

  @override
  void initState() {
    super.initState();
    this.diaryId = widget.diaryId;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet( /// 스크롤 되는 BottomSheet이다.
      /// 피그마 디자인을 기반으로 비율을 측정하였다.
      initialChildSize: 0.33, // 초기 값 설정 (부모 컴포넌트 기준 비율)
      minChildSize: 0.33, // 최소 값 설정 (부모 컴포넌트 기준 비율)
      maxChildSize: 1.0, // 최대 값 설정 (부모 컴포넌트 기준 비율)
      /// BottomSheet에 나타날 컴포넌트
      builder: (BuildContext context, ScrollController scrollController) {
        return DiaryViewForBottomSheet(scrollController: scrollController, diaryId: diaryId);
      }
    );
  }

  /// 바텀 시트 크기를 조정할 수 있는 handler 컴포넌트
  ///
  /// 회색 바를 컴포넌트 중앙에 배치시킨다.
  SliverToBoxAdapter _sliverToBoxAdapter() {
    return SliverToBoxAdapter( // ScrollView 안에서 일반적인 위젯을 사용하게 해주는 위젯
      child: Center( // 위젯 중앙 정렬
        child: Container( // 컨테이너(위젯)을 추가하여, handler 모양을 추가한다.
          alignment: Alignment.center, // 중앙 정렬
          decoration: BoxDecoration(
            color: AppColors.gray300,
            // 모서리 굴곡 추가(타원형을 만들기 위함)
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.h), // 위젯 높이 지정
          width: 40.w, // 컨테이너(handler) 너비 지정
          height: 4.h, // 컨테이너(handler) 높이 지정
        ),
      )
    );
  }
}
