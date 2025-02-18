import 'package:ego/theme/color.dart';
import 'package:ego/widgets/button/custom_button1.dart';
import 'package:ego/widgets/textfield/custom_textfield1.dart';
import 'package:flutter/material.dart';

/// 사용자를 구분하는 로그인 스크린이다.
///
/// 대화하기 페이지로 이동하기 위해 필수적으로 거쳐야 하는 스크린이다.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// [controller] Textfield를 조작하기 위한 객체이다.
  final TextEditingController controller = TextEditingController();

  /// [active] 버튼 활성화 여부이다.
  bool active = false;

  /// _updateButtonState 초기화
  @override
  void initState() {
    super.initState();
    controller.addListener(_updateButtonState);
  }

  /// _updateButtonState 제거
  @override
  void dispose() {
    controller.removeListener(_updateButtonState);
    controller.dispose();
    super.dispose();
  }

  /// 버튼의 활성화 여부를 관리하는 함수이다.
  /// TODO: 올바른 이메일 주소에 대한 validation 조건문은 여기에 기입할 것
  void _updateButtonState() {
    setState(() {
      active = controller.text.isNotEmpty;
    });
  }

  /// 페이지 이동 함수이다.
  void sendMailMethod(BuildContext context) {
    Navigator.pushNamed(context, 'SendMail');
  }

  /// 페이지 이동 함수이다.
  void termsOfUseMethod(BuildContext context) {
    Navigator.pushNamed(context, 'TermsOfUse');
  }

  /// 페이지 이동 함수이다.
  void privacyPolicyMethod(BuildContext context) {
    Navigator.pushNamed(context, 'PrivacyPolicy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: Container(
      width: MediaQuery.of(context).size.width, // 화면 전체 너비로 설정
      padding: EdgeInsets.symmetric(horizontal: 20.0), // 위젯 간 패딩 20.0 설정
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
        children: [
          _title(), // 하위에 제목 및 설명이 있다.
          SizedBox(height: 40.0), // 추가 Padding 역할
          _input(context), // 하위에 텍스트필드 및 전송 버튼이 있다.
          SizedBox(height: 20.0), // 추가 Padding 역할
          _terms(context), // 하위에 약관 이동 버튼이 있다.
        ],
      ),
    ));
  }

  /// 스크린 정보를 설명하는 텍스트 영역이다.
  ///
  /// 스크린의 제목과 짧은 설명이 있다.
  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      spacing: 2.0, // 열간 간격 지정
      children: [
        // '회원가입'을 명시하는 텍스트
        Text(
          "회원가입",
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        // 스크린의 역할을 설명하는 텍스트
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

  /// 전송할 이메일 정보를 입력하는 영역이다.
  Widget _input(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
      children: [
        CustomTextfield1( // 사용자가 인증번호를 전송할 이메일을 작성하는 영역이다.
          hintText: '이메일', // 아무것도 작성하지 않으면, '이메일'을 작성해둔다.
          controller: controller, // 텍스트필드에 작성된 정보를 알기 위한 controller 설정
        ),
        SizedBox( // 추가 Padding 역할
          height: 5.0,
        ),
        Text( // 사용자가 올바르지 않은 이메일을 작성할 시 나타나는 문구이다.
          !active ? "잘못된 유형의 이메일 주소입니다." : "",
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.errorBase,
          ),
        ),
        SizedBox( // 추가 Padding 역할
          height: 10.0,
        ),
        CustomButton1( // 인증번호 전송 요청 버튼이다.
          text: "인증메일 발송",
          confirmMethod: active ? () => sendMailMethod(context) : null, // active가 true일 때만 작동한다.
        )
      ],
    );
  }

  /// 서비스 이용약관과 개인정보 처리방침이 작성되는 영역이다.
  Widget _terms(BuildContext context) {
    return Column(
      children: [
        Divider( // _input과의 경계선이다.
          color: AppColors.gray300,
        ),
        SizedBox( // 추가 Padding 역할
          height: 20.0,
        ),
        Text( // 약관 동의에 대한 설명을하는 텍스트
          "가입과 동시에 아래의 약관에 동의합니다.",
          style: TextStyle(
              color: AppColors.gray600,
              fontSize: 12.0
          ),
        ),
        SizedBox( // 추가 Padding 역할
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // 위젯이 화면 중심에 배치되도록 지정
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton( // 서비스 이용약관 스크린으로 이동하기 위한 버튼이다.
              onPressed: () => termsOfUseMethod(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // 기본 TextButton에 존재하는 패딩을 제거한다.
                minimumSize: Size.zero, // 기본 TextButton에 존재하는 패딩을 제거한다.
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 기본 TextButton에 존재하는 패딩을 제거한다.
                overlayColor: AppColors.transparent, // 버튼 클릭 시 나타나는 색상을 투명화한다.
              ),
              child: Text(
                "서비스 이용약관",
                style: TextStyle(color: AppColors.gray300, fontSize: 10.0),
              ),
            ),
            Container( // '서비스 이용약관'과 '개인정보 처리방침' 버튼 간의 수직 경계선이다.
              height: 10.0,
              child: VerticalDivider(
                color: AppColors.gray300,
                thickness: 1,
              ),
            ),
            TextButton( // 개인정보 처리방침 스크린으로 이동하기 위한 버튼이다.
              onPressed: () => privacyPolicyMethod(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // 기본 TextButton에 존재하는 패딩을 제거한다.
                minimumSize: Size.zero, // 기본 TextButton에 존재하는 패딩을 제거한다.
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 기본 TextButton에 존재하는 패딩을 제거한다.
                overlayColor: AppColors.transparent, // 버튼 클릭 시 나타나는 색상을 투명화한다.
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
