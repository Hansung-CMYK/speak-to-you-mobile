import 'package:ego/sample/cmyk-46/tmp_screen.dart';
import 'package:ego/screens/record/record_screen.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/appbar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../screens/chat/chat_room_list_screen.dart';

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() async {
  await initializeDateFormatting();
  runApp(
    ProviderScope(
      child: MainScreenTest(),
    ),
  );
}

class MainScreenTest extends StatelessWidget {
  const MainScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
          title: '앱 바 테스트 페이지',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: 'Main',
          routes: {
            'Main': (context) => Consumer(
              builder: (context, ref, child) {
                return SampleMainScreen();
              },
            ),
            'Settings': (context) => TmpScreen(text: "설정 페이지"),
            'Alert': (context) => TmpScreen(text: "알림 페이지"),
            'Diary': (context) => TmpScreen(text: "일기 페이지"),
            'Recap' : (context) => TmpScreen(text: "RECAP 페이지"),
          }
      ),
    );
  }
}

/// [MainAppBar]를 사용하기 위한 Screen 구성 예시
///
/// ConsumerStatefulWidget을 이용하여, TabBarController 상태를 지속적으로 관리한다.
class SampleMainScreen extends ConsumerStatefulWidget {
  @override
  _SampleMainAppBarScreenState createState() => _SampleMainAppBarScreenState();
}

class _SampleMainAppBarScreenState extends ConsumerState<SampleMainScreen>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;

  /// _tabCntroller 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  /// _tabCntroller 제거
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 각 Screen으로 이동하기 위한 Navigator AppBar이다.
      appBar: MainAppBar(_tabController),

      /// MainAppBar에서 선택된 Tab의 Screen이 나타나는 영역이다.
      body: TabBarView(
        controller: _tabController,
        children: [
          TmpScreen(text: "스피크 페이지"), // TODO: 스피크 스크린에 연결
          RecordScreen(), // 캘린더 페이지
          ChatListScreen()
        ],
      ),
    );
  }
}