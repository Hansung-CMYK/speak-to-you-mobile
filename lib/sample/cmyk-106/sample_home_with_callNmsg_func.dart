import 'package:ego/screens/home_callNmsg_func.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final egoListAsync = ref.watch(egoListProvider);

    return egoListAsync.when(
      data: (egoList) => HomeScreenCallnMsg(egoList: []),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('에러 발생: $err'))),
    );
  }
}
