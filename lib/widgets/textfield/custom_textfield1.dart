import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';

class CustomTextfield1 extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextfield1(
      {super.key, required this.hintText, required this.controller});

  @override
  _CustomTextfield1State createState() => _CustomTextfield1State();
}

class _CustomTextfield1State extends State<CustomTextfield1> {
  late final TextEditingController _controller = widget.controller;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: AppColors.gray100,
        filled: true,
        hintStyle: TextStyle(
          color: AppColors.gray300,
        ),
        labelStyle: TextStyle(
          color: AppColors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray200),
          borderRadius: BorderRadius.circular(8.0),
        ),
        border: InputBorder.none,
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  size: 18.0,
                ),
                onPressed: () {
                  _controller.clear();
                },
              )
            : null,
      ),
    );
  }
}
