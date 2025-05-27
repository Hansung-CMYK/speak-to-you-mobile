import 'package:ego/theme/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SwipeActionContainer extends StatefulWidget {
  final Widget child;
  final Function onCall;
  final Function onText;

  SwipeActionContainer({
    required this.child,
    required this.onCall,
    required this.onText,
  });

  @override
  _SwipeActionContainerState createState() => _SwipeActionContainerState();
}

class _SwipeActionContainerState extends State<SwipeActionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  double _dragOffset = 0; // 현재 드래그된 위치

  // 배경색 설정을 위한 변수
  Color _backgroundColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta ?? 0;

      if (_dragOffset > 0) {
        _backgroundColor = AppColors.callColor; // 전화 (초록색)
      } else if (_dragOffset < 0) {
        _backgroundColor = AppColors.royalBlue; // 문자 (파란색)
      } else {
        _backgroundColor = AppColors.transparent; // 기본 배경 (투명)
      }

      // 드래그된 위치로 애니메이션을 즉시 업데이트
      _offsetAnimation = Tween<Offset>(
        begin: Offset(_dragOffset, 0),
        end: Offset(_dragOffset, 0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (_dragOffset > screenWidth * 0.5) {
      _animateSlide(screenWidth, () => widget.onCall());
    } else if (_dragOffset < -screenWidth * 0.5) {
      _animateSlide(-screenWidth, () => widget.onText());
    } else {
      _animateSlide(0, null);
    }
  }

  void _animateSlide(double targetOffset, VoidCallback? onComplete) {
    _offsetAnimation = Tween<Offset>(
      begin: Offset(_dragOffset, 0),
      end: Offset(targetOffset, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.reset();
    _controller.forward();

    // 기존 리스너 중복 방지 (한 번만 실행되게 처리)
    void listener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.removeStatusListener(listener);

        // 1. 콜백 호출
        if (onComplete != null) onComplete();

        // 2. 복귀가 필요한 경우 (전화 or 문자 → 실행 후 원상 복귀)
        if (targetOffset != 0) {
          // 애니메이션 없이 원래 위치로 복귀
          setState(() {
            _dragOffset = 0;
            _offsetAnimation = Tween<Offset>(
              begin: Offset.zero,
              end: Offset.zero,
            ).animate(_controller); // 애니메이션 없음
            _backgroundColor = Colors.transparent;
          });
        } else {
          // 그냥 되돌아온 경우 (드래그 부족)
          setState(() {
            _dragOffset = 0;
            _backgroundColor = Colors.transparent;
          });
        }
      }
    }

    _controller.addStatusListener(listener);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Stack(
        children: [
          // 카드 뒷 배경 UI (색 + 아이콘 + 텍스트)
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                if (_dragOffset > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/icon/phone_icon.svg"),
                          SizedBox(width: 8.w),
                          Text(
                            "전화",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (_dragOffset < 0)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "채팅",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SvgPicture.asset("assets/icon/chat_icon.svg"),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // 애니메이션 적용된 위치에 자식 위젯
          AnimatedBuilder(
            animation: _offsetAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: _offsetAnimation.value,
                child: widget.child,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
