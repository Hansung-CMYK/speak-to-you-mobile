import 'package:ego/models/ego_model_v1.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/screens/home_callNmsg_func.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../../firebase_options.dart';
// import '../../services/firebase_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../../screens/alarm/alarm_screen.dart';
import '../../services/local_notifications_service.dart';
import '../../theme/theme.dart';
import 'package:permission_handler/permission_handler.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

Future<void> main() async {
  await initializeDateFormatting('ko');

  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  // final firebaseMessagingService = FirebaseMessagingService.instance();
  // await firebaseMessagingService.init(localNotificationsService: localNotificationsService);

  await requestNotificationPermission();
  final localNotificationsService = LocalNotificationsService.instance();
  await localNotificationsService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // merge 됨에 따라 egoInfoModel에서 EgoModel로 변경됨
  final List<EgoModelV2>  dummyEgoList=[];

  // final List<EgoModel> dummyEgoList = [
  //   EgoModel(
  //     id: 1,
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '루나',
  //     egoBirth: '1998/04/12',
  //     egoMBTI: 'INTJ',
  //     egoPersonality: '분석적이고 계획적인 성격',
  //     egoSelfIntro: '안녕하세요, 미래를 계획하는 것을 좋아하는 루나입니다.',
  //   ),
  //   EgoModel(
  //     id: '2',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '마루',
  //     egoBirth: '2000/10/03',
  //     egoMBTI: 'ENFP',
  //     egoPersonality: '활발하고 에너지 넘치는 타입',
  //     egoSelfIntro: '세상을 밝게 만들고 싶은 마루예요!',
  //   ),
  //   EgoInfoModel(
  //     id: '3',
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '세린',
  //     egoBirth: '1995/12/25',
  //     egoMBTI: 'INFJ',
  //     egoPersonality: '섬세하고 사려 깊은 이상주의자',
  //     egoSelfIntro: '작은 것도 깊게 생각하는 세린입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '4',
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '준호',
  //     egoBirth: '1999/07/07',
  //     egoMBTI: 'ISTP',
  //     egoPersonality: '실용적이고 조용한 문제 해결사',
  //     egoSelfIntro: '효율이 최고의 가치인 준호예요.',
  //   ),
  //   EgoInfoModel(
  //     id: '5',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '하늘',
  //     egoBirth: '2001/03/14',
  //     egoMBTI: 'INFP',
  //     egoPersonality: '감성적이고 창의적인 몽상가',
  //     egoSelfIntro: '마음 속 이야기를 담는 하늘입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '6',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '태윤',
  //     egoBirth: '1997/11/30',
  //     egoMBTI: 'ENTJ',
  //     egoPersonality: '리더십이 뛰어난 전략가',
  //     egoSelfIntro: '계획을 세우고 이끄는 것이 즐거운 태윤입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '7',
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '미소',
  //     egoBirth: '1996/09/09',
  //     egoMBTI: 'ESFP',
  //     egoPersonality: '즉흥적이고 사교적인 성격',
  //     egoSelfIntro: '어디서든 웃음을 주는 미소예요!',
  //   ),
  //   EgoInfoModel(
  //     id: '8',
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '유리',
  //     egoBirth: '1994/05/20',
  //     egoMBTI: 'ISFJ',
  //     egoPersonality: '조용하고 책임감 있는 보호자형',
  //     egoSelfIntro: '모든 사람을 편하게 해주는 유리입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '9',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '진우',
  //     egoBirth: '1993/01/01',
  //     egoMBTI: 'ESTJ',
  //     egoPersonality: '체계적이고 현실적인 관리자',
  //     egoSelfIntro: '명확한 규칙 속에서 살아가는 진우입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '10',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '아라',
  //     egoBirth: '2002/08/08',
  //     egoMBTI: 'ENFJ',
  //     egoPersonality: '열정적이고 사람을 끌어당기는 리더형',
  //     egoSelfIntro: '사람들과 함께 성장하고 싶은 아라입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '11',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '사과',
  //     egoBirth: '2002/08/08',
  //     egoMBTI: 'ENFJ',
  //     egoPersonality: '열정적이고 사람을 끌어당기는 리더형',
  //     egoSelfIntro: '사람들과 함께 성장하고 싶은 아라입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '12',
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '바나나',
  //     egoBirth: '2002/08/08',
  //     egoMBTI: 'ENFJ',
  //     egoPersonality: '열정적이고 사람을 끌어당기는 리더형',
  //     egoSelfIntro: '사람들과 함께 성장하고 싶은 아라입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '13',
  //     egoIcon: 'assets/image/ego_1.png',
  //     egoName: '옥수수',
  //     egoBirth: '2002/08/08',
  //     egoMBTI: 'ENFJ',
  //     egoPersonality: '열정적이고 사람을 끌어당기는 리더형',
  //     egoSelfIntro: '사람들과 함께 성장하고 싶은 아라입니다.',
  //   ),
  //   EgoInfoModel(
  //     id: '14',
  //     egoIcon: 'assets/image/ego_icon.png',
  //     egoName: '옥바바',
  //     egoBirth: '2002/08/08',
  //     egoMBTI: 'ENFJ',
  //     egoPersonality: '열정적이고 사람을 끌어당기는 리더형',
  //     egoSelfIntro: '사람들과 함께 성장하고 싶은 아라입니다.',
  //   ),
  // ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder:
          (context, child) => MaterialApp(
        title: 'Home Screen With Call N Msg Func',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        navigatorKey: navigatorKey,
        home: HomeScreenCallnMsg(egoList: dummyEgoList),
        routes: {
          '/alert': (context) => AlarmScreen(),
        },
      ),
    );
  }
}