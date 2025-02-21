import 'dart:async';
import 'dart:io';

import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerificationScreen extends StatefulWidget {
  final Widget nextPage;

  const EmailVerificationScreen({
    super.key,
    required this.nextPage,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationScreen> {
  final int pinLength = 4;
  String codeBuffer = '';
  final TextEditingController _controller = TextEditingController();
  final FocusNode _hiddenFocusNode = FocusNode(); // 숨겨진 TextField용 FocusNode

  // flutter_keyboard_visibility 패키지를 이용한 키보드 표시 여부 관리
  late final StreamSubscription<bool> _keyboardSubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    // flutter_keyboard_visibility 패키지로 키보드 상태 감지
    _keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });

    // Android는 최초 진입 시 키보드 자동 표시, iOS는 자동 표시하지 않고 사용자가 직접 토글하도록 함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Platform.isIOS) {
        _hiddenFocusNode.requestFocus();
      }
    });

    // 입력값 변경시 codeBuffer 업데이트
    _controller.addListener(() {
      setState(() {
        codeBuffer = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hiddenFocusNode.dispose();
    _keyboardSubscription.cancel();
    super.dispose();
  }

  Widget _buildPinCell(int index) {
    String displayChar = index < codeBuffer.length ? codeBuffer[index] : '';
    bool isFilled = index < codeBuffer.length;

    return GestureDetector(
      onTap: () {
        // iOS에서는 탭 시 포커스 토글, Android는 포커스가 없으면 요청, 있으면 강제 키보드 표시
        if (Platform.isIOS) {
          if (_hiddenFocusNode.hasFocus) {
            _hiddenFocusNode.unfocus();
          } else {
            _hiddenFocusNode.requestFocus();
          }
        } else {
          if (!_hiddenFocusNode.hasFocus) {
            _hiddenFocusNode.requestFocus();
          } else {
            SystemChannels.textInput.invokeMethod('TextInput.show');
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 8.0.w),
        width: 64.r,
        height: 64.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          border: Border.all(
            color: isFilled ? AppColors.gray900 : AppColors.gray200,
          ),
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Text(
            displayChar,
            key: ValueKey(displayChar),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.gray900,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // flutter_keyboard_visibility로 감지한 키보드 상태에 따라 하단 여백 적용
    final buttonBottomOffset = _isKeyboardVisible ? 12.h : 40.h;

    return Scaffold(
      appBar: StackAppBar(
        title: '',
      ),
      // body 전체를 GestureDetector로 감싸서 화면 탭 시 포커스 해제
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '인증 메일을 발송했어요',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'blahblah@gmail.com',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '로 인증 번호가 발송됐어요.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.gray600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '받은 번호를 입력하면 인증이 완료 돼요.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // PIN 입력 영역 탭 시 iOS에서는 포커스 토글
                        if (Platform.isIOS) {
                          if (_hiddenFocusNode.hasFocus) {
                            _hiddenFocusNode.unfocus();
                          } else {
                            _hiddenFocusNode.requestFocus();
                          }
                        } else {
                          _hiddenFocusNode.requestFocus();
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 숨겨진 TextField (화면에 보이지 않음)
                          SizedBox(
                            width: 0.w,
                            height: 0.h,
                            child: TextField(
                              controller: _controller,
                              focusNode: _hiddenFocusNode,
                              // iOS에서는 autofocus 제거 (자동 포커스가 키보드 고정을 유발)
                              autofocus: !Platform.isIOS,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(pinLength),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // 입력된 내용을 표시하는 4칸
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(pinLength, _buildPinCell),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '인증 메일이 오지 않는 경우 스팸함을 확인해주세요.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.gray600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            /// TODO: 인증번호 재전송 로직
                          },
                          child: Text(
                            '인증번호 재전송',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray900,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, buttonBottomOffset),
          child: Row(
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: codeBuffer.length == pinLength
                        ? AppColors.primary
                        : AppColors.gray300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 56.h,
                  child: TextButton(
                    onPressed: codeBuffer.length == pinLength
                        ? () {
                            /// TODO 인증번호 검증 & 다음 페이지로 이동
                          }
                        : null,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(AppColors.white),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      overlayColor: WidgetStateProperty.all(
                          AppColors.white.withValues(alpha: 0.1)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
