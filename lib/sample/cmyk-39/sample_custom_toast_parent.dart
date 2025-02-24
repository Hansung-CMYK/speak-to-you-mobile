import 'package:ego/sample/cmyk-39/sample_custom_toast_child.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(
  MaterialApp(
    builder: FToastBuilder(),
    home: SampleCustomToast(),
    navigatorKey: navigatorKey,
  ),
);

class SampleCustomToast extends StatefulWidget {
  const SampleCustomToast({super.key});

  @override
  State<SampleCustomToast> createState() => _SampleCustomToastState();
}

class _SampleCustomToastState extends State<SampleCustomToast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Toast")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SampleCustomToastChild()),
            );
          },
          child: Text("go to Test"),
        ),
      ),
    );
  }
}
