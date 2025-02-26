import 'package:ego/utils/util_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../theme/color.dart';
import '../../utils/constants.dart';

/// 일기보기(캘린더)에서 이용하는 캘린더 위젯이다.
///
/// TODO: 현재는 다른 화면으로 이동하고 돌아오면 초기화 된다. (퍼블이므로 수정하진 않음)
/// TODO: 캘린더에 6주까지 있을 때 해결법 (디자인 수정 중)
class DiaryCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiaryCalendarState();
}

class _DiaryCalendarState extends State<DiaryCalendar> {
  /// [_focusedDay] 화면에 띄워지는 날짜. 기본적으로 DateTime.now()이다.
  DateTime _focusedDay = DateTime.now(); // 현재 달

  /// [_emotions] 사용자가 일기를 작성한 날짜와 당시의 감정(대표 감정 1개)을 담은 Map 컨테이너
  final Map<DateTime, Emotion> _emotions = {
    DateTime(2025, 2, 10): Emotion.happiness, // ex) 2025-02-10, 행복
    DateTime(2025, 2, 15): Emotion.disappointment,
    DateTime(2025, 2, 20): Emotion.sadness,
    DateTime(2025, 2, 26): Emotion.embarrassment,
  };

  @override
  Widget build(BuildContext context) {
    return Padding( // 캘린더 Padding 지정
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: TableCalendar(
        /// 기본 캘린더 속성 정보들
        locale: 'ko_KR', // 한국어 타입으로 변경, 기념일 등 정보를 전달하는 것으로 추정
        firstDay: DateTime(2000, 1, 1), // 캘린더 시작 날짜, 2000-01-01, 변경 가능하다.
        lastDay: DateTime(DateTime.now().year, DateTime.now().month, 42), // 이번 달이 일요일인 기준 6주 (7*6=42)
        focusedDay: _focusedDay, // 조회할 날짜(객체) 고정
        pageAnimationEnabled: false, // 페이지 애니메이션 제거. 어차피 현재 날짜 고정이라 없어도 됨

        /// 캘린더의 상단부 정보들
        headerStyle: _headerStyle(), // 캘린더의 날짜(월)을 조정하는 영역

        /// 캘린더 요일 부분 정보들
        ///
        /// `daysOfWeekHeight`에 + 8.h가 추가되는 이유는 `_headerStyle()` 주석 참고
        daysOfWeekStyle: _daysOfWeekStyle(), // 캘린더의 요일이 나타나는 영역
        daysOfWeekHeight: 20.h + 8.h, // 캘린더의 요일이 나타나는 영역 높이

        /// 캘린더 핵심부 정보들
        calendarStyle: _calendarStyle(), // 날짜를 보여주는 영역
        calendarBuilders: _calendarBuilders(), // 캘린더의 동적 정보를 명시하는 영역
        rowHeight: 60.h, // 날짜를 보여주는 영역 높이
        sixWeekMonthsEnforced: true, // 6주 보기

        /// 상단부 조작 관련 정보
        onPageChanged: (focusedDay) { // 사용자가 다음 달로 이동하는 것을 방지하는 내용
          DateTime now = DateTime.now();
          // 다음 달로 넘어갔을 때,
          if (focusedDay.year > now.year || (focusedDay.year == now.year && focusedDay.month > now.month)) {
            setState(() {
              _focusedDay = DateTime.now(); // 다시 현재 달로 고정
            });
          } else {
            _focusedDay = focusedDay;
          }
        },

        /// 캘린더 마커(사용자 일기 감정)를 표시하는 영역
        eventLoader: (day) => _loadEvents(day),
      ),
    );
  }

  /// 이벤트(사건)를 불러오는 함수이다.
  ///
  /// 실질적인 동작은 `_calendarBuilder()/markerBuilders`에서 진행되며
  /// 해당 영역에서는 감정에 알맞는 EmotionIcon의 경로를 불러온다.
  ///
  /// (2025-02-27) 어떤 이윤진 모르겠는데, 서비스 내적으로 `enum Emotion`을 `String`으로
  /// 인식하고 있다. 현재 임시 방편으로 아이콘의 경로(String)을 전달하게 만들었다.
  List<String> _loadEvents(DateTime day) {
    DateTime date = DateTime(day.year, day.month, day.day);
    if (_emotions.containsKey(date)) {
      // enum Emotion의 아이콘 경로를 리스트로 반환
      return [UtilFunction.emotionTypeToPath(_emotions[date]!)];
    }
    return []; // 빈 리스트는 `_calendarBuilder()/markerBuilders`에서 공백으로 렌더링 한다.
  }

  /// 캘린더의 상단부를 디자인하는 함수이다.
  ///
  /// (2025-02-27) 현재 라이브러리에 월 이동 버튼을 중심으로 모으는 기능이 존재하지 않는다.
  /// 현재 임시 방편으로 피그마의 horizontal Padding을 참고하여 header의 maigin을 주는 방식으로 보완하였다.
  /// 추후 해당 부분이 업데이트 된다면 수정할 것.
  HeaderStyle _headerStyle() {
    return HeaderStyle(
      formatButtonVisible: false, // 캘린더 날짜 단위 변경 버튼 제거
      titleCentered: true, // 현재 월을 캘린더 중심에 배치한다.
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      // 화살표를 중심으로 모으기 위한 margin 설정.
      headerMargin: EdgeInsets.symmetric(horizontal: 88.w), // TODO: 하드 코딩임 `TableCalendar`가 업데이트 된다면 개선할 것
      /// (2025-02-27) 현재 라이브러리에는 요일(daysOfWeek)에 자체 Padding이 존재하지 않는다.
      /// 현재 임시 방편으로 header의 Bottom에 Padding을 주는 방식으로 보완하였다.
      ///
      /// 같은 이유로 daysOfWeek의 하단에 Padding 효과를 주기 위해 height를 증가시켰고,
      /// header의 하단 Padding을 줄이는 방식으로 이를 보완하였다.
      ///
      /// row와 daysOfWeekHeight 간의 패딩을 위해 4.h 제거 (상단 4.h는 Header에 들어간 패딩에서 제거)
      headerPadding: EdgeInsets.only(bottom: 16.h - 4.h),
      // 각 화살표의 padding과 margin을 제거
      rightChevronPadding: EdgeInsets.zero,
      rightChevronMargin: EdgeInsets.zero,
      leftChevronPadding: EdgeInsets.zero,
      leftChevronMargin: EdgeInsets.zero,
    );
  }

  /// 캘린더의 요일이 나타나는 영역
  ///
  /// 두 매개 변수의 속성 값은 동일하다.
  DaysOfWeekStyle _daysOfWeekStyle() {
    return DaysOfWeekStyle(
      weekdayStyle: TextStyle( // 평일 관련
        color: AppColors.gray400,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      weekendStyle: TextStyle( // 주말 관련
        color: AppColors.gray400,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// 캘린더 핵심부 정보들
  ///
  /// `todayTextStyle`, `todayDecoration` 과
  /// `outsideTextStyle`, `disabledTextStyle`을 제외한 모든 매개 변수의 속성 값은 동일하다.
  CalendarStyle _calendarStyle() {
    return CalendarStyle(
      cellAlignment: Alignment.topCenter, // 날짜 배치 위치
      cellMargin: EdgeInsets.zero, // 날짜 칸의 영역
      // 날짜 칸의 세부 영역(날짜 텍스트 배치 위치)
      cellPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),

      // 당일 날짜 칸은 흰색 TextColor를 이용한다.
      todayTextStyle: _todayTextStyle(),
      // 모두 동일한 속성 값(`_defaultTextStyle()`)을 사용한다.
      selectedTextStyle: _defaultTextStyle(),
      defaultTextStyle: _defaultTextStyle(),
      weekendTextStyle: _defaultTextStyle(),
      holidayTextStyle: _defaultTextStyle(),
      // 모두 동일한 속성 값(`_outsideTextStyle()`)을 사용한다.
      outsideTextStyle: _outsideTextStyle(),
      disabledTextStyle: _outsideTextStyle(),

      // 당일 날짜 칸은 회색 BoxColor를 이용한다.
      todayDecoration: _todayDecoration(),
      // 모두 동일한 속성 값(`_defaultDecoration`)을 사용한다.
      selectedDecoration: _defaultDecoration(),
      defaultDecoration: _defaultDecoration(),
      weekendDecoration: _defaultDecoration(),
      holidayDecoration: _defaultDecoration(),
      outsideDecoration: _defaultDecoration(),
      disabledDecoration: _defaultDecoration(),
    );
  }

  /// 캘린더의 디자인을 동적으로 제작하는 함수이다.
  ///
  /// 감정 이모티콘(Marker) 배치를 진행한다.
  CalendarBuilders _calendarBuilders() {
    return CalendarBuilders(
      // 감정 이모티콘을 동적으로 디자인한다. `events`는 감정 아이콘의 경로이다.
      markerBuilder: (context, date, events) {
        return Padding( // 날짜 텍스트와의 간격을 위함
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: ClipOval( // 원형 이미지를 위함
            child: SizedBox( // 이모티콘이 나타나는 공간
              width: 24.w,
              height: 24.h,
              child: events.isNotEmpty // 해당 날짜에 일기를 작성했는지 여부(Emotion 유무)
                ? SvgPicture.asset(events[0]) // 존재한다면, Emotion의 아이콘을 가져온다.
                : date.isBefore(DateTime.now()) // 존재하지 않는다면, 당일과 해당 날짜를 비교하여
                  ? ColoredBox(color: AppColors.gray200) // 당일 날짜 이전이면, 짙은 회색
                  : ColoredBox(color: AppColors.gray100), // 당일 날짜 이후이면, 옅은 회색 (일기 존재할 수 없음)
            ),
          ),
        );
      },
    );
  }

  /// 당일의 날짜 글자 속성을 지정하는 함수이다.
  ///
  /// 색상을 제외하면, 다른 텍스트들과 동일하다.
  TextStyle _todayTextStyle() {
    return TextStyle( // 당일 텍스트 스타일
      color: AppColors.white, // 흰색
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  /// 평일의 날짜 글자 속성을 지정하는 함수이다.
  ///
  /// 색상을 제외하면, 다른 텍스트들과 동일하다.
  TextStyle _defaultTextStyle() {
    return TextStyle( // 평일 텍스트 스타일
      color: AppColors.black, // 검정색
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  /// 주말의 날짜 글자 속성을 지정하는 함수이다.
  ///
  /// 색상을 제외하면, 다른 텍스트들과 동일하다.
  TextStyle _outsideTextStyle() {
    return TextStyle( // 이번 달이 아닌 날짜의 텍스트 스타일
      color: AppColors.gray400, // 회색
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  /// 당일의 날짜 칸의 디자인을 하는 함수이다.
  ///
  /// 다른 칸과 다르게 짙은 색으로 나타난다.(색 반전)
  Decoration _todayDecoration() {
    return BoxDecoration(
      color: AppColors.gray700, // 배경색
      border: Border(
        bottom: BorderSide(
          width: 1.h, // 테두리 크기
          color: AppColors.gray200, // 하단에만 border 추가
        ),
      ),
    );
  }

  /// 당일이 아닌 날짜 칸의 디자인을 하는 함수이다.
  Decoration _defaultDecoration() {
    return BoxDecoration(
      color: AppColors.transparent, // 배경색을 투명하게 설정
      border: Border(
        bottom: BorderSide(
          width: 1.h, // 테두리 크기
          color: AppColors.gray200, // 하단에만 border 추가
        ),
      ),
    );
  }
}