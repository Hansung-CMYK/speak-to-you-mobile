import 'package:ego/screens/email_verification.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:flutter/material.dart';

class EmailSentScreen extends StatefulWidget {
  final Widget nextPage;
  const EmailSentScreen({
    super.key,
    required this.nextPage,
  });

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(
                  nextPage: widget.nextPage,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(
        title: '',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/sent.gif', // 발송 완료 GIF
              width: 200,
              height: 200,
            ),
            const Text(
              '발송 완료!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
