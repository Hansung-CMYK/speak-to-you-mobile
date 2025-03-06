import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/screens/egoreview/ego_review.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(SampleTodayEgoReview());
}

class SampleTodayEgoReview extends StatelessWidget {
  const SampleTodayEgoReview({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
        title: 'Ego Review',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Check Today Ego!!')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final EgoInfoModel tmpEgoModel = EgoInfoModel(id: '1', egoIcon: 'assets/image/ego_icon.png', egoName: 'Power', egoBirth: '', egoPersonality: '', egoSelfIntro: '');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EgoReviewScreen(egoInfoModel: tmpEgoModel),
              ),
            );
          },
          child: Text('Review Today\'s EGO'),
        ),
      ),
    );
  }
}
