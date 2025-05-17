import 'package:ego/models/ego_model_v1.dart';
import 'package:ego/screens/voice_chat/voice_chat_screen.dart';
import 'package:ego/widgets/appbar/main_app_bar.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/egocard/swipable_ego_card.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';
import 'package:ego/widgets/egoicon/ego_list_item_gradient.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'egolistview/ego_list_blurred_screen.dart';

class HomeScreenCallnMsg extends ConsumerStatefulWidget {
  final List<EgoModel> egoList;

  const HomeScreenCallnMsg({super.key, required this.egoList});

  @override
  HomeChatScreenState createState() => HomeChatScreenState();
}

class HomeChatScreenState extends ConsumerState<HomeScreenCallnMsg>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;
  late final List<EgoModel> egoList;
  late EgoModel selectedEgo; // 선택된 EGO의 정보

  /// _tabCntroller 초기화
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    egoList = widget.egoList;
    selectedEgo = egoList.first;
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
      appBar: MainAppBar(_tabController),
      body: Column(
        children: [
          // 상단 스토리 EGO 리스트
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: SizedBox(
              height: 80.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                children:
                egoList
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final ego = entry.value;

                  if (index == 10) {
                    // 11번째는 더보기 버튼
                    return buildEgoListItem("", () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder:
                              (_, __, ___) =>
                              BlurredListScreen(
                                // uid는 시스템상에 존재한다 가정
                                uid: "test",
                                onEgoSelected: (selected) {
                                  setState(
                                        () => selectedEgo = selected,
                                  );
                                },
                              ),
                        ),
                      );
                    }, isMoreBtn: true);
                  } else if (index > 10) {
                    return null;
                  }

                  return index == 0
                      ? buildEgoListItemGradient(
                    ego.profileImage,
                        () => setState(() => selectedEgo = ego),
                  )
                      : buildEgoListItem(
                    ego.profileImage,
                        () => setState(() => selectedEgo = ego),
                  );
                })
                    .whereType<Widget>()
                    .toList(),
              ),
            ),
          ),

          // TODO 여기서 EGO가 움직입니다.
          Expanded(
            child: Container(
              color: Colors.green.withOpacity(0.3), // 영역 표시용 배경색
              child: Center(
                child: Container(
                  child: Image.asset(
                    'assets/image/ego_1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // 현재 EGO 카드
          _buildSelectedEGO(),
        ],
      ),
    );
  }

  // 현재 클릭된 EGO의 정보 Card
  Widget _buildSelectedEGO() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: SwipeActionContainer(
        onCall: () {
          // 전화 걸기 액션
          // uid는 시스템 상에서 관리된다 가정
          //TODO egoInfoModel을 EGOModel로 바꾸어서 발생하는 ERROR 이후 VoiceChatScreen FE issue에서 처리 예정
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         VoiceChatScreen(uid: "User_1", egoInfoModel: selectedEgo),
          //   ),
          // ).then((_) {
          //   // VoiceChatScreen에서 돌아온 후, HomeScreenCallnMsg 화면을 새로 로드
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomeScreenCallnMsg(egoList: egoList),
          //     ),
          //   );
          // });
        },

        onText: () {
          // 문자 보내기 액션
          print('문자 보내기');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '현재 EGO',
                    style: TextStyle(
                      color: AppColors.gray600,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    selectedEgo.name,
                    style: TextStyle(
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              buildEgoListItem(selectedEgo.profileImage, () {}),
            ],
          ),
        ),
      ),
    );
  }
}
