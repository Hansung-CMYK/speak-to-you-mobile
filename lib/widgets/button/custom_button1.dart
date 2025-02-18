import 'package:flutter/material.dart';

import '../../theme/color.dart';

class CustomButton1 extends StatefulWidget {
  final String text;
  final Function confirmMethod;

  const CustomButton1({required this.text, required this.confirmMethod});

  @override
  _CustomButton1State createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.confirmMethod(context),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primary), // TODO: 애니메이션 넣을거면 넣기
        foregroundColor: WidgetStatePropertyAll(AppColors.white), // TODO: 애니메이션 넣을거면 넣기
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        fixedSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width, 56)), // TODO: 높이가 HardCoding 되어있음.
      ),
      child: Text(
        widget.text,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}