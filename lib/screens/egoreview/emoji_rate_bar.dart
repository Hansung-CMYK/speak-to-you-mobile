import 'package:ego/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmojiRateBar extends StatefulWidget {
  final ValueChanged<int> onRatingSelected; // 선택된 점수를 전달하는 콜백
  final String title;

  const EmojiRateBar({
    super.key,
    required this.title,
    required this.onRatingSelected,
  });

  @override
  State<EmojiRateBar> createState() => _EmojiRateBarState();
}

class _EmojiRateBarState extends State<EmojiRateBar> {
  late final title;
  int selectedIndex = -1; // 선택된 아이콘 (1~3), 기본값은 -1 (선택 안됨)

  final List<String> iconPaths = [
    'assets/icon/bad_rate.svg',
    'assets/icon/good_rate.svg',
    'assets/icon/best_rate.svg',
  ];

  final List<String> rateName = ['불편해요', '편해요', '만족해요'];

  @override
  void initState() {
    super.initState();
    this.title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray200, width: 1.h)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [

          // 평가 제목
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.gray900,
            ),
          ),

          SizedBox(height: 12.h),

          // 평가 아이콘
          Stack(
            children: [
              Positioned(
                top: 30,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Container(
                  height: 2.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: AppColors.lightGray,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isSelected = (selectedIndex == index + 1);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index + 1;
                      });
                      widget.onRatingSelected(selectedIndex); // 부모 위젯으로 점수 전달
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            iconPaths[index],
                            width: 60.w,
                            height: 60.h,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            rateName[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.errorDark
                                  : AppColors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );

  }
}

// color: (selectedIndex == index + 1) ? CupertinoColors.activeOrange : CupertinoColors.inactiveGray,
