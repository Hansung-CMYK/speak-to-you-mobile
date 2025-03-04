import 'package:flutter/material.dart';

/// 화면 이동을 보여주기 위한 임시 클래스
class TmpScreen extends StatelessWidget {
  final String text;

  const TmpScreen({super.key, this.text = "임시 페이지"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(text)
      ),
    );
  }
}