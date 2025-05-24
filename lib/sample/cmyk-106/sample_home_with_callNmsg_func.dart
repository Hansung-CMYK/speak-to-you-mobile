import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/providers/chat/chat_room_provider.dart';
import 'package:ego/screens/speak_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../providers/ego_provider.dart';
import '../../theme/theme.dart';

Future<void> main() async {
  await initializeDateFormatting('ko');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MaterialApp(
        title: 'Home Screen With Call N Msg Func',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const HomeScreenCallnMsgWrapper(),
      ),
    );
  }
}

class HomeScreenCallnMsgWrapper extends ConsumerWidget {
  const HomeScreenCallnMsgWrapper({super.key});

  // 1단계 : uid와 일치하는 ChatRoomList를 가져온다.
  // 2단계 : ChatRoomList에는 egoId가 있으므로 egoId별로 ego를 가져온다.
  // 3단계 : 가져온 EGO정보로 main화면의 EGOList를 그린다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // uid는 시스템에 존재
    final chatRoomListAsync = ref.watch(chatRoomProvider('user_id_001'));

    return chatRoomListAsync.when(
      data: (chatRoomList) {
        // 각 egoId를 기반으로 egoModel Future 리스트를 만듦
        final futures = chatRoomList.map(
              (chatRoom) => ref.watch(egoByIdProviderV2(chatRoom.egoId).future),
        ).toList();

        // 여러 개의 future를 기다리기 위해 Future.wait 사용
        return FutureBuilder<List<EgoModelV2>>(
          future: Future.wait(futures),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('에러 발생: ${snapshot.error}')),
              );
            } else if (snapshot.hasData) {
              final egoList = snapshot.data!;
              return SpeakScreen();
            } else {
              return const Scaffold(
                body: Center(child: Text('예상치 못한 오류')),
              );
            }
          },
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('에러 발생1: $err'))),
    );
  }
}
