import 'package:ego/theme/color.dart';
import 'package:ego/widgets/button/custom_button1.dart';
import 'package:ego/widgets/textfield/custom_textfield1.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController controller = TextEditingController();
  bool active = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    controller.removeListener(_updateButtonState);
    controller.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      active = controller.text.isNotEmpty;
    });
  }

  void sendMailMethod(BuildContext context) {
    Navigator.pushNamed(context, 'SendMail');
  }

  void termsOfUseMethod(BuildContext context) {
    Navigator.pushNamed(context, 'TermsOfUse');
  }

  void privacyPolicyMethod(BuildContext context) {
    Navigator.pushNamed(context, 'PrivacyPolicy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: ,
        body: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(
            height: 40.0,
          ),
          _input(context),
          SizedBox(
            height: 20.0,
          ),
          _terms(context),
        ],
      ),
    ));
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.0,
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

  Widget _input(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfield1(
          hintText: '이메일',
          controller: controller,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          !active ? "잘못된 유형의 이메일 주소입니다." : "",
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.errorBase,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        CustomButton1(
          text: "인증메일 발송",
          confirmMethod: active ? () => sendMailMethod(context) : null,
        )
      ],
    );
  }

  Widget _terms(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: AppColors.gray300,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "가입과 동시에 아래의 약관에 동의합니다.",
          style: TextStyle(color: AppColors.gray600, fontSize: 12.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => termsOfUseMethod(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: AppColors.transparent,
              ),
              child: Text(
                "서비스 이용약관",
                style: TextStyle(color: AppColors.gray300, fontSize: 10.0),
              ),
            ),
            Container(
              height: 10.0,
              child: VerticalDivider(
                color: AppColors.gray300,
                thickness: 1,
              ),
            ),
            TextButton(
              onPressed: () => privacyPolicyMethod(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: AppColors.transparent,
              ),
              child: Text(
                "개인정보 처리방침",
                style: TextStyle(color: AppColors.gray300, fontSize: 10.0),
              ),
            )
          ],
        )
      ],
    );
  }
}
