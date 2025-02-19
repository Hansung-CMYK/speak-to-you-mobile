import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: ""),
      body: SizedBox(
        width: double.maxFinite,
        child: Container(

        ),
      ),
    );
  }

}