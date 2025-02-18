import 'package:ego/theme/color.dart';
import 'package:ego/widgets/button/custom_button1.dart';
import 'package:ego/widgets/textfield/custom_textfield1.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController controller =  TextEditingController();

  SignUpScreen({super.key});

  void sendMailMethod(BuildContext context) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            _input(),
            _button(context),
            _terms(context),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5.0,
        children: [
          Text(
            "회원가입",
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "로그인 시 사용할 이메일을 입력해주세요.",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: AppColors.gray600,
            ),
          ),
        ],
    );
  }

  Widget _input() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfield1(hintText: '이메일', controller: controller,),
        Text(
          "잘못된 유형의 이메일 주소입니다.",
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.errorBase,
          ),
        ),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return CustomButton1(
        text: "인증메일 발송",
        confirmMethod: () => sendMailMethod(context),
    );
  }

  Widget _terms(BuildContext context) {
    return Divider(
      color: AppColors.gray300,
    );
  }
}