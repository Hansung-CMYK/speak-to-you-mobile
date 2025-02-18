import 'package:flutter/material.dart';

import '../../theme/color.dart';

class CustomButton1 extends StatefulWidget {
  final String text;
  final Function? confirmMethod;

  const CustomButton1({required this.text, this.confirmMethod});

  @override
  _CustomButton1State createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          widget.confirmMethod != null ? () => widget.confirmMethod!() : null,
      style: TextButton.styleFrom(
        disabledBackgroundColor: AppColors.gray300,
        disabledForegroundColor: AppColors.white,
        backgroundColor: AppColors.primary, // TODO: 애니메이션 넣을거면 넣기
        foregroundColor: AppColors.white, // TODO: 애니메이션 넣을거면 넣기
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        fixedSize: Size(MediaQuery.of(context).size.width,
            56), // TODO: 높이가 HardCoding 되어있음.
      ),
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
      ),
    );
  }
}
