import 'package:ego/models/ego_info_model.dart';
import 'package:ego/screens/voice_chat/voice_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../theme/theme.dart';

Future<void> requestMicrophonePermission() async {
  var status = await Permission.microphone.status;
  if (!status.isGranted) {
    await Permission.microphone.request();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter Binding 초기화
  await requestMicrophonePermission(); // 마이크 권한 요청
  await initializeDateFormatting('ko'); // 날짜 포맷 초기화
  runApp(ProviderScope(child: MyApp())); // 앱 실행
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            title: 'EGO Edit Test',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Sample(),
          ),
    );
  }
}

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VoiceChatScreen(
                    egoInfoModel: EgoInfoModel(
                      id: '1',
                      egoIcon: '',
                      egoName: 'Power',
                      egoBirth: '2002/05/03',
                      egoPersonality: '활발, 착함',
                      egoMBTI: 'ENFJ',
                      egoSelfIntro:
                          "나는 파워! 피의 악마다! 인간 따윈 우습지만, 냥이는 소중해! 머리도 좋고 싸움도 최고지! 덴지, 나를 왕처럼 떠받들라!",
                    ),
                    uid: "user_id_001",
                  );
                },
              ),
            );
          },
          child: const Text('일기 작성'),
        ),
      ),
    );
  }
}
