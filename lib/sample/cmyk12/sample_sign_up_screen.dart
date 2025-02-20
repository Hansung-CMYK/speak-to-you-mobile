import 'package:ego/sample/cmyk12/tmpscreen/tmp_privacy_policy_screen.dart';
import 'package:ego/sample/cmyk12/tmpscreen/tmp_send_mail_screen.dart';
import 'package:ego/sample/cmyk12/tmpscreen/tmp_terms_of_use_screen.dart';
import 'package:ego/screens/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme.dart';

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
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
        title: '앱 바 테스트 페이지',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: 'SignUp',
        routes: {
          'SignUp': (context) => SignUpScreen(),
          'SendMail': (context) => TmpSendMailScreen(),
          'TermsOfUse': (context) => TmpTermsOfUseScreen(),
          'PrivacyPolicy': (context) => TmpPrivacyPolicyScreen(),
        },
      ),
    );
  }
}
