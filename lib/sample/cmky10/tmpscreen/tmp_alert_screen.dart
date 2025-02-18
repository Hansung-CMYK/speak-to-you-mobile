import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';

class TmpAlertScreen extends StatelessWidget {
  const TmpAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: "알림"),
      body: Center(child: Text("알림")),
    );
  }
}
