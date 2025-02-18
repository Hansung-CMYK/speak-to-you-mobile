import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hiddenFocusNode.requestFocus(); // 최초 화면 진입 시 키보드 표시
    });
    // 입력값이 변경될 때마다 codeBuffer를 갱신
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
    super.dispose();
  }

  Widget _buildPinCell(int index) {
    String displayChar = '';
    bool isFilled = index < codeBuffer.length;
    if (isFilled) {
      displayChar = codeBuffer[index];
    }
    return GestureDetector(
      onTap: () {
        if (!_hiddenFocusNode.hasFocus) {
          _hiddenFocusNode.requestFocus();
        } else {
          // 이미 포커스가 있는데 키보드가 내려간 경우 강제로 다시 표시
          SystemChannels.textInput.invokeMethod('TextInput.show');
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 64.w,
        height: 64.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          border: Border.all(
            color: isFilled ? AppColors.gray900 : AppColors.gray200,
          ),
          borderRadius: BorderRadius.circular(8.0),
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.gray900),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StackAppBar(
          title: '',
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '인증 메일을 발송했어요',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        'blahblah@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '로 인증 번호가 발송됐어요.',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.gray600),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '받은 번호를 입력하면 인증이 완료 돼요.',
                    style: TextStyle(fontSize: 14, color: AppColors.gray600),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(_hiddenFocusNode);
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 실제 입력을 받는 숨겨진 TextField
                            SizedBox(
                              width: 0,
                              height: 0,
                              child: TextField(
                                controller: _controller,
                                focusNode: _hiddenFocusNode,
                                autofocus: true,
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
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Text(
                        '인증 메일이 오지 않는 경우 스팸함을 확인해주세요.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray600,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          /// TODO 인증번호 재전송 로직
                        },
                        child: Text(
                          '인증번호 재전송',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray900,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: codeBuffer.length == 4
                            ? AppColors.primary
                            : AppColors.gray300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: codeBuffer.length == 4
                            ? () {
                                /// TODO 인증번호 검증 & 다음 페이지로
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => widget.nextPage,
                                  ),
                                );
                              }
                            : null,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
