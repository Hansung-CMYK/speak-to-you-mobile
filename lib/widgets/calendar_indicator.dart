import 'package:ego/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarIndicator extends StatefulWidget {
  final ValueChanged<DateTime>? onChanged;
  const CalendarIndicator({super.key, this.onChanged});

  @override
  _CalendarIndicatorState createState() => _CalendarIndicatorState();
}

class _CalendarIndicatorState extends State<CalendarIndicator> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  void _notifyChange() {
    if (widget.onChanged != null) {
      widget.onChanged!(DateTime(_selectedYear, _selectedMonth));
    }
  }

  void _changeMonth(bool isNext) {
    final currentYear = DateTime.now().year;
    final minYear = currentYear - 10;
    final maxYear = currentYear + 10;

    setState(() {
      if (isNext) {
        if (_selectedMonth == 12) {
          if (_selectedYear < maxYear) {
            _selectedMonth = 1;
            _selectedYear++;
          } else {
            // 최대 범위에 도달했을 때 처리 (예: 아무 동작 안함 또는 사용자에게 알림)
          }
        } else {
          _selectedMonth++;
        }
      } else {
        if (_selectedMonth == 1) {
          if (_selectedYear > minYear) {
            _selectedMonth = 12;
            _selectedYear--;
          } else {
            // 최소 범위에 도달했을 때 처리
          }
        } else {
          _selectedMonth--;
        }
      }
    });
    _notifyChange();
  }

  void _showDatePicker() {
    final currentYear = DateTime.now().year;
    List<int> years = List.generate(21, (index) => currentYear - 10 + index);
    int initialYearIndex = years.indexOf(_selectedYear);
    int initialMonthIndex = _selectedMonth - 1;
    int tempYearIndex = initialYearIndex;
    int tempMonthIndex = initialMonthIndex;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 396.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 52.h),
                  SizedBox(
                    height: 172.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: tempYearIndex,
                            ),
                            itemExtent: 32.h,
                            magnification: 1.1,
                            squeeze: 1.0,
                            diameterRatio: 100,
                            onSelectedItemChanged: (index) {
                              setModalState(() {
                                tempYearIndex = index;
                              });
                            },
                            children:
                                years
                                    .map(
                                      (year) => Center(
                                        child: Text(
                                          "$year년",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: tempMonthIndex,
                            ),
                            itemExtent: 32.h,
                            magnification: 1.1,
                            squeeze: 1.0,
                            diameterRatio: 100,
                            onSelectedItemChanged: (index) {
                              setModalState(() {
                                tempMonthIndex = index;
                              });
                            },
                            children: List.generate(
                              12,
                              (index) => Center(
                                child: Text(
                                  "${index + 1}월",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 52.h),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 56.h,
                          width: MediaQuery.of(context).size.width - 40.w,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedYear = years[tempYearIndex];
                                _selectedMonth = tempMonthIndex + 1;
                              });
                              _notifyChange();
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.white,
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "${years[tempYearIndex]}년 ${tempMonthIndex + 1}월 선택",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double yearWidth = 75;
    const double monthWidth = 45;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          iconSize: 20.r,
          color: AppColors.gray400,
          onPressed: () => _changeMonth(false),
        ),
        GestureDetector(
          onTap: _showDatePicker,
          child: SizedBox(
            width: yearWidth.w,
            child: Text(
              '$_selectedYear년',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _showDatePicker,
          child: SizedBox(
            width: monthWidth.w,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$_selectedMonth월',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          color: AppColors.gray400,
          iconSize: 20.r,
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () => _changeMonth(true),
        ),
      ],
    );
  }
}
