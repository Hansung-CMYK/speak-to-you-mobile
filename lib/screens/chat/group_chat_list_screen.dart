import 'package:ego/screens/chat/group_chat_room_screen.dart';
import 'package:ego/widgets/chat/group_chat_list_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ego/models/chat/chat_room_list_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';

import '../../models/chat/group_chat_list_model.dart';
import '../../services/chat/chat_room_service.dart';
import '../../services/ego/ego_service.dart';
import 'ego_chat_room_screen.dart';

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
  List<GroupChatRoomListModel> _chatRoomList = [];
  int? _selectedChatRoomId;

  int _pageNum = 0; // 페이지 번호
  bool _isLoading = false; // 로딩 상태 추적
  bool _hasMore = true;
  late ScrollController _scrollController; // 스크롤 컨트롤러

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    fetchChatRooms();
  }

  void _scrollListener() {
    // 스크롤이 리스트 끝에 가까워지면 새로운 데이터를 요청
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchChatRooms();
    }
  }

  Future<void> fetchChatRooms() async {
    // uid는 시스템상에 존재
    setState(() => _isLoading = true);
    final chatRooms = [
      GroupChatRoomListModel(
        id: 1,
        isDeleted: false,
        lastChatAt: DateTime.parse('2025-05-16'),
        personalityTag: '게임중독',
        uid: 'user1',
      ),
    ];

    if (chatRooms.isEmpty) {
      setState(() => _hasMore = false);
    }
    // 리스트에 누적
    setState(() {
      _chatRoomList.addAll(chatRooms);
      _pageNum++;
    });

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 3,
        thumbColor: AppColors.gray700,
        radius: Radius.circular(10.r),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _chatRoomList.length,
          itemBuilder: (context, index) {
            final chat = _chatRoomList[index];

            return InkWell(
              onTap: () {
                setState(() {
                  _selectedChatRoomId = chat.id;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => GroupChatRoomScreen(
                          chatRoomId: chat.id,
                          uid: chat.uid,
                          personalityTagName: chat.personalityTag,
                        ),
                  ),
                );
              },
              onLongPress: () async {
                final result = await showConfirmDialog(
                  context: context,
                  title: '채팅방을 나가시겠어요?',
                  content: '${chat.personalityTag} 채팅방에서 나가면 대화 내용이 삭제됩니다.',
                  dialogType: DialogType.info,
                  stack: true,
                  cancelText: '취소',
                  confirmText: '나가기',
                  confirmBackgroundColor: AppColors.red,
                  confirmForegroundColor: AppColors.white,
                  confirmOverlayColor: AppColors.white,
                );

                if (result == true) {
                  // uid는 시스템 상에 존재
                  // 삭제 요청

                  setState(() {
                    _chatRoomList.removeWhere(
                      (element) => element.id == chat.id,
                    );
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    buildGroupListItem(
                      _convertPersonalityToImagePath(chat.personalityTag),
                      () {},
                    ),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chat.personalityTag ?? '이름 없음',
                                style: TextStyle(
                                  color: AppColors.gray900,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                _formatTime(chat.lastChatAt),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.gray600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final isToday = now.difference(time).inDays < 1 && now.day == time.day;

    if (isToday) {
      final hour = time.hour;
      final minute = time.minute.toString().padLeft(2, '0');
      final amPm = hour < 12 ? '오전' : '오후';
      final displayHour = hour % 12 == 0 ? 12 : hour % 12;
      return '$amPm $displayHour:$minute';
    } else {
      return '${time.year}.${time.month.toString().padLeft(2, '0')}.${time.day.toString().padLeft(2, '0')}';
    }
  }

  String _convertPersonalityToImagePath(String personality) {
    switch (personality) {
      case '게임중독':
        return 'assets/image/game_chat_room.png';
      case '영화중독':
        return 'assets/image/movie_chat_room.png';
      case '음악중독':
        return 'assets/image/music_chat_room.png';
      case '애니중독':
        return 'assets/image/anime_chat_room.png';
      default:
        return 'assets/image/ego_icon.png'; // 기본 이미지 경로
    }
  }
}
