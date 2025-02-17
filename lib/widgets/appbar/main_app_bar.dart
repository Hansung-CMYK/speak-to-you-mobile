import 'package:ego/widgets/appbar/tmp_calendar_screen.dart';
import 'package:ego/widgets/appbar/tmp_speak_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/color.dart';
import '../../theme/theme.dart';
import '../ImageButton.dart';

/// [MainAppBar]는 SpeakToYou에서 가장 기본적으로 사용되는 AppBar이다.
///
/// '스피크'와 '캘린더' 페이지를 TabBar를 통해 navigating 한다.
/// '알림'과 '설정' 페이지를 Button을 통해 navigating 한다.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// (임시) 에고 아이콘 이미지가 저장된 Path이다.
  final String egoIconPath = 'assets/image/egoIcon.png';

  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  final TabController tabController;

  /// 생성자
  const MainAppBar(this.tabController, {super.key});

  /// 페이지 이동 함수이다.
  void alertMethod() {}
  void settingsMethod() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 18.0, 0),
      child: AppBar(
        toolbarHeight: kToolbarHeight + 70,
        title: DefaultTabController(
          // TabBar를 AppBar의 좌측에 배치하기 위함
          length: tabController.length, // 이용할 Tab은 2개로 지정
          child: TabBar(
            controller: tabController,
            isScrollable:
                true, // TabBar의 너비를 지정할 수 있게 한다.(Default: Maximum Width)
            tabAlignment: TabAlignment
                .start, // TabBar의 Tab들을 왼쪽으로 정렬시킨다. (Default: Center)
            labelPadding:
                EdgeInsets.symmetric(horizontal: 8.0), // 각 텍스트 간의 간격 지정
            indicator: BoxDecoration(), // 선택된 페이지의 밑줄 하이라이팅 제거
            labelStyle: TextStyle(
              // 선택된 Tab의 텍스트 속성
              color: AppColors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              // 선택되지 않은 Tab의 텍스트 속성
              color: AppColors.gray400,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              // 지정된 Tab * 알림과 설정은 탭이 아닌 버튼을 통해 다른 페이지로 이동한다.
              Tab(text: "스피크"),
              Tab(text: "캘린더"),
            ],
          ),
        ),
        actions: [
          // '알림'과 '설정'을 AppBar의 우측에 배치하기 위한
          Row(
            children: [
              IconButton(
                // 알림 페이지로 이동하기 위한 Button
                icon: Icon(Icons.alarm), // TODO: 디자인 확정되면 변경할 것
                iconSize: 30,
                onPressed: alertMethod,
              ),
              ImageButton(
                // 설정 페이지로 이동하기 위한 Button
                imagePath: egoIconPath,
                onTab: settingsMethod,
                width: 35.0,
                height: 35.0,
                radius: 100.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// AppBar의 사이즈 조정을 위한 필수 getter
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);
}

/// AppBar 단위 테스트 코드
/// SampleAppBarTest를 통해 위젯 비율을 조정하고 관리함
void main() {
  runApp(
    ProviderScope(
      child: MainAppBarTest(),
    ),
  );
}

class MainAppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '앱 바 테스트 페이지',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Consumer(
        builder: (context, ref, child) {
          return SampleMainAppBarScreen();
        },
      ),
    );
  }
}

/// [MainAppBar]를 사용하기 위한 Screen 구성 예시
///
/// ConsumerStatefulWidget을 이용하여, TabBarController 상태를 지속적으로 관리한다.
class SampleMainAppBarScreen extends ConsumerStatefulWidget {
  @override
  _SampleMainAppBarScreenState createState() => _SampleMainAppBarScreenState();
}

class _SampleMainAppBarScreenState extends ConsumerState<SampleMainAppBarScreen>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;

  /// _tabCntroller 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          TmpSpeakScreen(), // TODO: 스피크 스크린에 연결
          TmpCalendarScreen(), // TODO: 캘린더 스크린에 연결
        ],
      ),
    );
  }
}
