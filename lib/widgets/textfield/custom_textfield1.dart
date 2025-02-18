import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// '로그인'과 '회원가입'에서 이용할 텍스트 필드를 모듈화 한 클래스이다.
class CustomTextfield1 extends StatefulWidget {
  /// [hintText] 텍스트 필트 초기에 나타날 내용 문구
  final String hintText;
  /// [controller] Textfield를 조작하기 위한 객체이다.
  final TextEditingController controller;

  /// [hintText] 텍스트 필트 초기에 나타날 내용 문구
  /// [controller] Textfield를 조작하기 위한 객체이다.
  const CustomTextfield1({super.key, required this.hintText, required this.controller});

  @override
  _CustomTextfield1State createState() => _CustomTextfield1State();
}

class _CustomTextfield1State extends State<CustomTextfield1> {
  late final TextEditingController _controller = widget.controller;

  /// _controller 초기화
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  /// _controller 제거
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller, // 텍스트필드 정보를 알기 위한 controller 설정
      decoration: InputDecoration(
        filled: true, // 텍스트 필트 배경 색상 추가 여부
        fillColor: AppColors.gray100, // 배경 색상
        hintText: widget.hintText, // 사용자가 설정한 힌트 텍스트 설정
        hintStyle: TextStyle(color: AppColors.gray300), // 힌트 텍스트 색상
        labelStyle: TextStyle(color: AppColors.black), // 작성한 텍스트 색상
        focusedBorder: OutlineInputBorder( // 텍스트 작성 시, 테두리 속성
          borderSide: BorderSide(color: Colors.black), // 테두리 색상
          borderRadius: BorderRadius.circular(8), // 모서리 굴곡
        ),
        enabledBorder: OutlineInputBorder( // 텍스트 미작성 시, 테두리 속성
          borderSide: BorderSide(color: AppColors.gray200), // 테두리 색상
          borderRadius: BorderRadius.circular(8), // 모서리 굴곡
        ),
        border: InputBorder.none, // 삭정 문구의 하이라이팅 제거
        suffixIcon: _controller.text.isNotEmpty // 문구 전체 제거 버튼, 문구가 있을 때만 나타난다.
          ? IconButton(
              icon: Icon(
                Icons.close,
                size: 20.w, // TODO: 아이콘에 맞게 조정할 것
              ),
              onPressed: () => _controller.clear(), // 텍스트 필드 문구 전체를 제거하는 함수
            )
          : null,
      ),
    );
  }
}
