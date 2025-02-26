import 'package:ego/utils/util_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../theme/color.dart';
import '../../utils/constants.dart';

/// TODO: 현재는 다른 화면으로 이동하고 돌아오면 초기화 된다. (퍼블이므로 수정하진 않음)
/// TODO: 캘린더에 6주까지 있을 때 해결법 (디자인 수정 중)
class DiaryCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiaryCalendarState();
}

class _DiaryCalendarState extends State<DiaryCalendar> {
  DateTime _focusedDay = DateTime.now(); // 현재 달

  // 이벤트 데이터를 저장
  final Map<DateTime, Emotion> _events = {
    DateTime(2025, 2, 10): Emotion.happiness,
    DateTime(2025, 2, 15): Emotion.disappointment,
    DateTime(2025, 2, 20): Emotion.sadness,
    DateTime(2025, 2, 26): Emotion.embarrassment,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime(2000, 1, 1),
        lastDay: DateTime(DateTime.now().year, DateTime.now().month, 31), // 이번 달까지만 가능
        focusedDay: _focusedDay,
        headerStyle: _headerStyle(),
        daysOfWeekStyle: _daysOfWeekStyle(),
        calendarStyle: _calendarStyle(),
        daysOfWeekHeight: 28.h,
        rowHeight: 60.h,

        calendarBuilders: _calendarBuilders(),

        eventLoader: (day) => _loadEvents(day),

        onPageChanged: (focusedDay) {
          // 사용자가 다음 달로 이동하는 것을 방지
          DateTime now = DateTime.now();
          if (focusedDay.year > now.year || (focusedDay.year == now.year && focusedDay.month > now.month)) {
            setState(() {
              _focusedDay = DateTime.now(); // 다시 현재 달로 고정
            });
          } else {
            _focusedDay = focusedDay;
          }
        },

        pageAnimationEnabled: false, // 페이지 애니메이션 제거
      ),
    );
  }

  List<String> _loadEvents(DateTime day) {
    DateTime date = DateTime(day.year, day.month, day.day);
    if (_events.containsKey(date)) {
      return [UtilFunction.emotionTypeToPath(_events[date]!)];
    }
    return [];
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
      // row와 daysOfWeekHeight 간의 패딩을 위해 4.h 제거 (상단 4.h는 Header에 들어간 패딩에서 제거)
      headerPadding: EdgeInsets.only(bottom: 16.h - 4.h),
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
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      weekendStyle: TextStyle(
        color: AppColors.gray400,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  CalendarStyle _calendarStyle() {
    return CalendarStyle(
      cellAlignment: Alignment.topCenter,
      cellMargin: EdgeInsets.zero,
      cellPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),

      todayTextStyle: _defaultTextStyle(),
      selectedTextStyle: _defaultTextStyle(),
      defaultTextStyle: _defaultTextStyle(),
      weekendTextStyle: _defaultTextStyle(),
      holidayTextStyle: _defaultTextStyle(),
      outsideTextStyle: _outsideTextStyle(),
      disabledTextStyle: _outsideTextStyle(),

      todayDecoration: _baseDecoration(),
      selectedDecoration: _baseDecoration(),
      defaultDecoration: _baseDecoration(),
      weekendDecoration: _baseDecoration(),
      holidayDecoration: _baseDecoration(),
      outsideDecoration: _baseDecoration(),
      disabledDecoration: _baseDecoration(),
    );
  }

  CalendarBuilders _calendarBuilders() {
    return CalendarBuilders(
      todayBuilder: (context, date, events) {
        return _todayCalendar();
      },
      markerBuilder: (context, date, events) { // 마커 디자인
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: ClipOval(
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: events.isNotEmpty
                ? SvgPicture.asset(events[0])
                : date.isBefore(DateTime.now())
                  ? ColoredBox(color: AppColors.gray200)
                  : ColoredBox(color: AppColors.gray100),
            ),
          ),
        );
      },
    );
  }

  Widget _todayCalendar() {
    return Container(
      decoration: _baseDecoration(),
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: AppColors.primary),
            borderRadius: BorderRadius.circular(37),
          ),
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Text(
          DateTime.now().day.toString(),
          style: _defaultTextStyle(),
        ),
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

  Decoration _baseDecoration() {
    return BoxDecoration(
      color: AppColors.transparent, // 배경색을 투명하게 설정
      border: Border(
        bottom: BorderSide(
          width: 1.h,
          color: AppColors.gray200, // 하단에만 border 추가
        ),
      ),
    );
  }
}