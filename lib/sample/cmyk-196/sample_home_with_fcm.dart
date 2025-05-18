import 'package:ego/models/ego_model_v1.dart';
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
  final List<EgoModelV1> dummyEgoList = [
    EgoModelV1(
      id: 1,
      name: '홍길동',
      introduction: '안녕하세요, 홍길동입니다.',
      profileImage: 'assets/image/ego_icon.png',
      mbti: 'INTJ',
      personality: '분석적이고 조용한 성격',
      createdAt: DateTime.now().subtract(Duration(days: 10)),
    ),
    EgoModelV1(
      id: 2,
      name: '김영희',
      introduction: '반갑습니다, 김영희에요.',
      profileImage: 'assets/image/ego_icon.png',
      mbti: 'ENFP',
      personality: '활발하고 사교적인 성격',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

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