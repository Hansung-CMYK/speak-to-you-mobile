import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/button/radius_button.dart';
import 'package:ego/widgets/textfield/radius_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// [active] 버튼 활성화 여부이다.
  bool active = false;

  /// _updateButtonState 초기화
  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  /// _updateButtonState 제거
  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _emailController.dispose();
    _passwordController.removeListener(_updateButtonState);
    _passwordController.dispose();
    super.dispose();
  }

  /// 버튼의 활성화 여부를 관리하는 함수이다.
  /// TODO: 올바른 로그인에 대한 validation 조건문은 여기에 기입할 것
  void _updateButtonState() {
    setState(() {
      active = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  void loginMethod(BuildContext context) {
    Navigator.pushNamed(context, 'Home');
  }

  void findIdMethod(BuildContext context) {
    Navigator.pushNamed(context, 'FindId');
  }

  void findPasswordMethod(BuildContext context) {
    Navigator.pushNamed(context, 'FindPassword');
  }

  void signUpMethod(BuildContext context) {
    Navigator.pushNamed(context, 'SignUp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                SizedBox(height: 40.h,),
                _login(context),
                SizedBox(height: 24.h,),
                _findAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "로그인",
          style: TextStyle(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          "이메일과 비밀번호를 입력하세요.",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }

  Widget _login(BuildContext context) {
    return Column(
      children: [
        RadiusTextfield(
          hintText: "이메일",
          controller: _emailController,
        ),
        SizedBox(
          height: 8.h,
        ),
        RadiusTextfield(
          hintText: "비밀번호(8~16자 영문,숫자,특수문자)",
          controller: _passwordController,
          isObscure: true,
        ),
        SizedBox(
          height: 40.h,
        ),
        RadiusButton(
          text: "로그인",
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
          confirmMethod: active ? () => loginMethod(context) : null,
        ),
      ],
    );
  }

  Widget _findAccount(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        findTextButton(
          text: "아이디 찾기",
          onPressed: () => findIdMethod(context)
        ),
        findText("/"),
        findTextButton(
          text: "비밀번호 찾기",
          onPressed: () => findPasswordMethod(context)
        ),
        findText("/"),
        findTextButton(
          text: "회원가입",
          onPressed: () => signUpMethod(context)
        ),
      ],
    );
  }

  Widget findText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
    );
  }

  Widget findTextButton({required String text, required Function onPressed}) {
    return TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, // 기본 TextButton에 존재하는 패딩을 제거한다.
          minimumSize: Size.zero, // 기본 TextButton에 존재하는 패딩을 제거한다.
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 기본 TextButton에 존재하는 패딩을 제거한다.
          overlayColor: AppColors.transparent, // 버튼 클릭 시 나타나는 색상을 투명화한다.
        ),
        child: findText(text),
    );
  }
}