import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/color.dart';

class TopCallTimeBanner extends StatefulWidget {
  final String egoName;

  const TopCallTimeBanner({
    super.key,
    required this.egoName,
  });

  @override
  State<TopCallTimeBanner> createState() => _TopCallTimeBannerState();
}

class _TopCallTimeBannerState extends State<TopCallTimeBanner> {
  late Timer _timer;
  int _elapsedSeconds = 0;
  bool _isBlinking = true; // 깜빡이는 상태를 관리

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        _isBlinking = !_isBlinking; // 1초마다 깜빡임 상태를 반전
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment(1, 0),
            end: Alignment(-1, 0),
            colors: [
              AppColors.royalBlue,
              AppColors.amethystPurple,
              AppColors.softCoralPink,
              AppColors.vividOrange,
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI랑 수다 폭발 중!",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.gray600,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.egoName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // 가장 큰 원
                  Container(
                    width: 24.r, // 가장 큰 원 크기
                    height: 24.r, // 가장 큰 원 크기
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isBlinking
                          ? AppColors.activeCall
                          : AppColors.transparent
                    ),
                    child: Center(
                      // 중간 크기의 원
                      child: Container(
                        width: 16.r, // 중간 크기의 원 크기
                        height: 16.r, // 중간 크기의 원 크기
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Center(
                          // 가장 작은 원
                          child: Container(
                            width: 8.r, // 가장 작은 원 크기
                            height: 8.r, // 가장 작은 원 크기
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isBlinking
                                  ? AppColors.activeCall
                                  : AppColors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _formattedTime,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
