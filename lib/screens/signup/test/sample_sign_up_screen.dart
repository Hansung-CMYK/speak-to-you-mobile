import 'package:ego/screens/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: SignUpScreenTest(),
    ),
  );
}

class SignUpScreenTest extends StatelessWidget {
  const SignUpScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '앱 바 테스트 페이지',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Consumer(
        builder: (context, ref, child) {
          return SignUpScreen();
        },
      ),
    );
  }
}