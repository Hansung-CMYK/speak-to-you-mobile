import 'package:ego/models/ego_info_model.dart';
import 'package:ego/widgets/bottomsheet/today_ego_intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852), // 화면 해상도에 맞춰 설정
      builder: (context, child) {
        return MaterialApp(home: ButtonScreen());
      },
    );
  }
}

class ButtonScreen extends StatelessWidget {
  EgoInfoModel egoInfoModel = EgoInfoModel(
    id: "1",
    egoIcon: "assets/image/ego_icon.png",
    egoName: "사과 ",
    egoBirth: "2001/07/07",
    egoPersonality: "활발함",
    egoSelfIntro:
        "사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아사과 짱 좋아",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ego Intro Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                showTodayEgoIntroSheet(context, egoInfoModel);
              },
              child: Text('나의 EGO'),
            ),
            ElevatedButton(
              onPressed: () {
                showTodayEgoIntroSheet(
                  context,
                  egoInfoModel,
                  isOtherEgo: true,
                  canChatWithHuman: false,
                  unavailableReason: "EGO와 더 많이 대화하세요!",
                  onChatWithEgo: () {
                    print("EGO와 채팅");
                  },
                  onChatWithHuman: () {
                    print("사람과 채팅");
                  },
                );
              },
              child: Text('타인 EGO - 비활성화'),
            ),
            ElevatedButton(
              onPressed: () {
                showTodayEgoIntroSheet(
                  context,
                  egoInfoModel,
                  isOtherEgo: true,
                  canChatWithHuman: true,
                  onChatWithEgo: () {
                    print("EGO와 채팅");
                  },
                  onChatWithHuman: () {
                    print("사람과 채팅");
                  },
                );
              },
              child: Text('나의 EGO - 활성화'),
            ),
          ],
        ),
      ),
    );
  }
}
