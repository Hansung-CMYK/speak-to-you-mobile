import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/button/radius_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('ko', ''), Locale('en', '')],
            home: Scaffold(
              appBar: StackAppBar(title: '개인정보 수정'),
              body: EditProfile(),
            ),
          ),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  // 초기 생일: 2001년 6월 15일
  DateTime _selectedBirthday = DateTime(2001, 6, 15);

  String get formattedBirthday {
    return "${_selectedBirthday.year}년 ${_selectedBirthday.month}월 ${_selectedBirthday.day}일";
  }

  void _showDatePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        DateTime tempPickedDate = _selectedBirthday;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              height: 396.h,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 12.h),
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.gray600,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24.h),
                    child: SizedBox(
                      height: 200.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: _selectedBirthday,
                              itemExtent: 32.h,
                              minimumYear: 1950,
                              maximumYear: 2025,
                              maximumDate: DateTime.now(),
                              onDateTimeChanged: (DateTime newDate) {
                                setModalState(() {
                                  tempPickedDate = newDate;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12.h, bottom: 40.h),
                    child: RadiusButton(
                      text:
                          "${tempPickedDate.year}년 ${tempPickedDate.month}월 ${tempPickedDate.day}일 선택",
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.primary,
                      confirmMethod: () {
                        setState(() {
                          _selectedBirthday = tempPickedDate;
                        });
                        Navigator.pop(context);
                      },
                    ),
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          // 생일 컨테이너를 누르면 하단 시트가 표시됩니다.
          InkWell(
            onTap: _showDatePickerBottomSheet,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.gray200,
                        width: 1.0.h,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '생일',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 332.w,
                            child: Text(
                              formattedBirthday,
                              style: TextStyle(
                                color: AppColors.gray600,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 6.r,
                        height: 12.r,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        child: SvgPicture.asset('assets/icon/right_arrow.svg'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
