import 'package:ego/screens/chat/group_chat_room_screen.dart';
import 'package:ego/utils/util_function.dart';
import 'package:ego/widgets/chat/group_chat_list_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/providers/ego_provider.dart';

/**
 * 그룹 채팅방 리스트를 확인하는 화면
 * */
class GroupChatListScreen extends ConsumerStatefulWidget {
  const GroupChatListScreen({super.key});

  @override
  _GroupChatListScreenState createState() => _GroupChatListScreenState();
}

class _GroupChatListScreenState extends ConsumerState<GroupChatListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ScrollController _scrollController; // 스크롤 컨트롤러

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // uid는 시스템에 존재
    final uid = 'uid2';
    final userEgo = ref.watch(fullEgoByUserIdProvider(uid)); // 현 사용자의 ego 조회

    return userEgo.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '문제가 발생했어요.\n${error.toString()}',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(fullEgoByUserIdProvider(uid));
                  },
                  child: const Text("다시 시도하기"),
                ),
              ],
            ),
          ),
      data: (ego) {
        final rawList = ego.personalityList;

        final filteredList =
            (rawList ?? []) // null이 아닌지 확인
                .where((tag) => UtilFunction.personalityTagToId(tag) != 0) // tag를 id로 바꿨을 때 0인지 확인 0은 값이 없는 것임
                .toList();

        return Scaffold(
          body: RawScrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            thickness: 3,
            thumbColor: AppColors.gray700,
            radius: Radius.circular(10.r),
            child:
                filteredList.isEmpty
                    ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text(
                          '그룹 대화방이 존재하지 않습니다.\n대화를 통해 나를 알려 주세요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.gray600,
                          ),
                        ),
                      ),
                    )
                    : ListView.builder(
                      controller: _scrollController,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final tag = filteredList[index];
                        final chatRoomId = UtilFunction.personalityTagToId(tag);

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => GroupChatRoomScreen(
                                      chatRoomId: chatRoomId,
                                      uid: uid,
                                      personalityTagName: tag,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              children: [
                                buildGroupListItem(
                                  _convertPersonalityToImagePath(tag),
                                  () {},
                                ),
                                SizedBox(width: 24.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tag,
                                        style: TextStyle(
                                          color: AppColors.gray900,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        );
      },
    );
  }

  // TODO 이미지 제작 필요
  String _convertPersonalityToImagePath(String personality) {
    switch (personality) {
      case '늘정주나':
        return 'assets/image/game_chat_room.png';
      case '시간마술사':
        return 'assets/image/movie_chat_room.png';
      case '존댓말자동완성':
        return 'assets/image/music_chat_room.png';
      case '식사개근상':
        return 'assets/image/anime_chat_room.png';
      default:
        return 'assets/image/ego_icon.png'; // 기본 이미지 경로
    }
  }
}
