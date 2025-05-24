import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ego/models/chat/chat_room_list_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';


import '../../services/chat/chat_room_service.dart';
import '../../services/ego/ego_service.dart';
import 'ego_chat_room_screen.dart';

/**
 * 개인 채팅방 리스트를 확인하는 화면
 * */
class PersonalChatListScreen extends ConsumerStatefulWidget  {
  const PersonalChatListScreen({super.key});

  @override
  _PersonalChatListScreenState createState() => _PersonalChatListScreenState();
}

class _PersonalChatListScreenState extends ConsumerState<PersonalChatListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ChatRoomListModel> _chatRoomList = [];
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
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchChatRooms();
    }
  }

  Future<void> fetchChatRooms() async {
    // uid는 시스템상에 존재
    setState(() => _isLoading = true);
    final chatRooms = await ChatRoomService.fetchChatRoomList(
      uid: "user_id_001", //uid는 시스템에 존재
      pageNum: _pageNum,
      pageSize: 11,
    );

    if (chatRooms.isEmpty) {
      setState(() => _hasMore = false);
    } else {
      // ego 정보 가져오기
      final egos = await EgoService.fetchEgoModelsForChatRooms(chatRooms, ref);

      // ChatRoomListModel 생성
      final chatRoomListModels = <ChatRoomListModel>[];

      for (int i = 0; i < chatRooms.length; i++) {
        final chatRoom = chatRooms[i];
        final ego = egos[i];

        chatRoomListModels.add(ChatRoomListModel(
          id: chatRoom.id,
          uid: chatRoom.uid,
          egoId: chatRoom.egoId,
          lastChatAt: chatRoom.lastChatAt,
          isDeleted: chatRoom.isDeleted,
          egoModel: ego
        ));
      }

      // 리스트에 누적
      setState(() {
        _chatRoomList.addAll(chatRoomListModels);
        _pageNum++;
      });
    }
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
                        (context) => EgoChatRoomScreen(
                          chatRoomId: chat.id,
                          uid: chat.uid,
                          egoModel: chat.egoModel,
                        ),
                  ),
                );
              },
              onLongPress: () async {
                final result = await showConfirmDialog(
                  context: context,
                  title: '채팅방을 나가시겠어요?',
                  content: '${chat.egoModel.name} 채팅방에서 나가면 대화 내용이 삭제됩니다.',
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
                  await ChatRoomService.deleteChatRoom(uid: "user_id_001",egoId:  chat.egoId);

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
                    buildEgoListItem(
                      chat.egoModel.profileImage,
                      () {},
                      radius: 25.5,
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
                                chat.egoModel.name ?? '이름 없음',
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
                          SizedBox(height: 4.h),
                          Text(
                            '최근 메시지',
                            style: TextStyle(
                              color: AppColors.gray600,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
}
