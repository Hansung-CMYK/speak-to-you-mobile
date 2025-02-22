import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../theme/color.dart';

class TmpSettingsScreen extends StatelessWidget {
  const TmpSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: "설정"),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: AppColors.gray400,
        child: Text("설정")
      ),
    );
  }
}
