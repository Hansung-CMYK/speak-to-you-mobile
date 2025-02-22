import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ego/sample/cmyk-39/sample_custom_toast_parent.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';

class SampleCustomToastChild extends StatefulWidget {
  const SampleCustomToastChild({super.key});

  @override
  State<SampleCustomToastChild> createState() => _SampleCustomToastChildState();
}

class _SampleCustomToastChildState extends State<SampleCustomToastChild> {
  late FToast fToast;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => Scaffold(
        appBar: AppBar(title: Text('Toast')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final customToast = CustomToast(
                    toastMsg: "인증메일 발송 완료!",
                    backgroundColor: AppColors.accent,
                    fontColor: AppColors.white,
                    iconPath: "assets/icon/complete.svg",
                  );
                  customToast.init(fToast);
                  customToast.showBottomToast();
                },
                child: Text("show bottom toast"),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  final customToast = CustomToast(
                    toastMsg: "인증메일 발송 완료!(Icon X)",
                    backgroundColor: AppColors.accent,
                    fontColor: AppColors.white,
                  );
                  customToast.init(fToast);
                  customToast.showTopToast();
                },
                child: Text("show top toast"),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  final customToast = CustomToast(
                    toastMsg: "인증메일 발송 완료!",
                    backgroundColor: AppColors.accent,
                    fontColor: AppColors.white,
                    iconPath: "assets/icon/complete.svg",
                  );
                  customToast.init(fToast);
                  customToast.showKeyboardTopToast();
                },
                child: Text("show custom positioned toast"),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 32.w),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "문자를 입력하세요",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
