import 'package:ego/sample/cmyk11/tmpscreen/tmp_google_login_screen.dart';
import 'package:ego/sample/cmyk11/tmpscreen/tmp_naver_login_screen.dart';
import 'package:ego/screens/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/logins/email_login_screen.dart';
import '../../screens/logins/main_login_screen.dart';
import '../../theme/theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: LoginScreenTest(),
    ),
  );
}

class LoginScreenTest extends StatelessWidget {
  const LoginScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
        title: '로그인 테스트 페이지',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: 'Login',
        routes: {
          'Login': (context) => MainLoginScreen(),
          'SignUp': (context) => SignUpScreen(),
          'EmailLogin': (context) => EmailLoginScreen(),
          'NaverLogin': (context) => TmpNaverLoginScreen(),
          'GoogleLogin': (context) => TmpGoogleLoginScreen(),
        },
      ),
    );
  }
}
