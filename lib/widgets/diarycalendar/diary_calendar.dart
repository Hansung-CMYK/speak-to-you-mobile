import 'package:ego/utils/util_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../theme/color.dart';
import '../../utils/constants.dart';

/// TODO: 현재는 다른 화면으로 이동하고 돌아오면 초기화 된다.
/// TODO: 요일 밑 색상은 지우기
/// TODO: 일기 작성 최저 최고 일자 정할 것
/// TODO: 날짜 선택 기능 회의하기
class DiaryCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiaryCalendarState();
}

class _DiaryCalendarState extends State<DiaryCalendar> {
  DateTime _focusedDay = DateTime.now(); // 당일 날짜
  late DateTime _selectedDay; // 선택한 날짜

  // 이벤트 데이터를 저장
  final Map<DateTime, Emotion> _events = {
    DateTime(2025, 2, 10): Emotion.happiness,
    DateTime(2025, 2, 15): Emotion.disappointment,
    DateTime(2025, 2, 20): Emotion.sadness,
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: TableCalendar(
        locale: 'ko_KR', // 한국어 버전
        firstDay: DateTime(2000, 1, 1), // 달력에 사용할 수 있는 첫 번째 날
        lastDay: DateTime(2025, 12, 31), // 달력에 사용할 수 있는 마지막 날
        focusedDay: _focusedDay, // 현재 목표일
        currentDay: DateTime.now(), // ???

        headerStyle: _headerStyle(), // 년 월 표시 영역
        daysOfWeekStyle: _daysOfWeekStyle(), // 요일 표시 영역 길이
        calendarStyle: _calendarStyle(), // 날짜 표시 영역
        daysOfWeekHeight: 20.h, // 텍스트가 잘림으로 하드코딩
        rowHeight: 60.h,

        calendarBuilders: _calendarBuilders(),
        eventLoader: (day) {
          DateTime date = DateTime(day.year, day.month, day.day);
          if(_events[date] != null) {
            return [UtilFunction.emotionTypeToPath(_events[date]!)];
          } else {
            return [];
          }
        }, // 마커 표시 위함

        selectedDayPredicate: (day) { // 현재 선택된 날짜를 지정, 캘린더에서 각 날짜를 렌더링할 때 호출
          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) { // 해당 날짜가 _selectedDay로 업데이트되고 화면이 업데이트되어 선택한 날짜에 대한 변경 사항을 표시
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
      ),
    );
  }

  HeaderStyle _headerStyle() {
    return HeaderStyle(
      formatButtonVisible: false, // 캘린더 날짜 단위 변경 버튼 제거
      titleCentered: true,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      headerMargin: EdgeInsets.symmetric(horizontal: 88.w), // TODO: 하드 코딩임 개선할 것
      headerPadding: EdgeInsets.only(bottom: 16.h),
      rightChevronPadding: EdgeInsets.zero,
      rightChevronMargin: EdgeInsets.zero,
      leftChevronPadding: EdgeInsets.zero,
      leftChevronMargin: EdgeInsets.zero,
    );
  }

  DaysOfWeekStyle _daysOfWeekStyle() {
    return DaysOfWeekStyle(
      weekdayStyle: TextStyle(
        color: AppColors.gray400,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      weekendStyle: TextStyle(
        color: AppColors.gray400,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  CalendarStyle _calendarStyle() {
    return CalendarStyle(
      cellAlignment: Alignment.topCenter,
      cellMargin: EdgeInsets.zero,
      cellPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),

      tableBorder: _tableBorder(),

      todayTextStyle: _defaultTextStyle(),
      selectedTextStyle: _defaultTextStyle(),
      defaultTextStyle: _defaultTextStyle(),
      weekendTextStyle: _defaultTextStyle(),
      holidayTextStyle: _defaultTextStyle(),
      outsideTextStyle: _outsideTextStyle(),

      todayDecoration: _todayDecoration(),
      selectedDecoration: _todayDecoration(),
    );
  }

  CalendarBuilders _calendarBuilders() {
    return CalendarBuilders(
      markerBuilder: (context, date, events) { // 마커 디자인
        return events.isNotEmpty
        ? Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: ClipOval(
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: SvgPicture.asset(events[0]),
            ),
          ),
        )
        : Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            width: 24.w,
            height: 24.h,
            decoration: ShapeDecoration(
              color: AppColors.gray200,
              shape: OvalBorder(),
            ),
          )
        );
      },
    );
  }

  TableBorder _tableBorder() {
    return TableBorder(
      horizontalInside : BorderSide(
        width: 1.h,
        color: AppColors.gray200,
      ),
      bottom: BorderSide(
        width: 1.h,
        color: AppColors.gray200,
      ),
    );
  }

  TextStyle _defaultTextStyle() {
    return TextStyle( // 평일 텍스트 스타일
      color: AppColors.black,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _outsideTextStyle() {
    return TextStyle( // 평일 텍스트 스타일
      color: AppColors.gray400,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  Decoration _todayDecoration() {
    return ShapeDecoration(
      color: AppColors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: AppColors.primary),
        borderRadius: BorderRadius.circular(37.r),
      ),
    );
  }
}