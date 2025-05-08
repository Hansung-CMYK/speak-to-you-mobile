import 'package:ego/widgets/appbar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/ego_info_model.dart';
import '../theme/color.dart';
import '../widgets/egoicon/ego_list_item.dart';
import '../widgets/egoicon/ego_list_item_gradient.dart';
import 'ego_list_blurred_screen.dart';

class HomeScreenCallnMsg extends ConsumerStatefulWidget {
  final List<EgoInfoModel> egoList;

  const HomeScreenCallnMsg({super.key, required this.egoList});

  @override
  HomeChatScreenState createState() => HomeChatScreenState();
}

class HomeChatScreenState extends ConsumerState<HomeScreenCallnMsg>
    with SingleTickerProviderStateMixin {
  /// 선택한 Tab과 Body를 매핑하는 Controller이다.
  late TabController _tabController;
  late final List<EgoInfoModel> egoList;
  late EgoInfoModel selectedEgo; // 전택된 EGO의 정보

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
                                      (_, __, ___) => BlurredListScreen(
                                        egoList: egoList,
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
                                ego.egoIcon,
                                () => setState(() => selectedEgo = ego),
                              )
                              : buildEgoListItem(
                                ego.egoIcon,
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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Slidable(
        key: Key(selectedEgo.id),
        startActionPane: ActionPane(
          motion: BehindMotion(),
          extentRatio: 0.3,
          dismissible: DismissiblePane(
            onDismissed: () {
              print('문자 보내기 실행!');
              // TODO: 문자 전송 함수 호출
            },
          ),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              onPressed: (_) {},
              // 클릭 불필요
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.message,
              label: '문자',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              // 👉 우 ➝ 좌: 전화 걸기
              print('전화 걸기 실행!');
              // TODO: 전화 관련 함수 호출
            },
          ),
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.phone,
              label: '전화',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    selectedEgo.egoName,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              buildEgoListItem(selectedEgo.egoIcon, () {}),
            ],
          ),
        ),
      ),
    );
  }
}
