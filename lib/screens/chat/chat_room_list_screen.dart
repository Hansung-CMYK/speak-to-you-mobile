import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/chat/chat_room_model.dart';
import '../../theme/color.dart';
import '../../types/dialog_type.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/egoicon/ego_list_item.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ChatRoomModel> _chatRoomList = [];
  int? _selectedChatRoomId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // TODO: 실제 API 요청 전에 임시 데이터
    _chatRoomList = [
      ChatRoomModel(
        id: 2,
        uid: 'user456',
        egoId: 102,
        lastChatAt: DateTime.now().subtract(Duration(hours: 2)),
        isDeleted: false,
        egoName: '마루',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 3,
        uid: 'user789',
        egoId: 103,
        lastChatAt: DateTime.now().subtract(Duration(hours: 4)),
        isDeleted: false,
        egoName: '세린',
        profileImage: 'assets/image/ego_icon.png',
      ),
      ChatRoomModel(
        id: 4,
        uid: 'user012',
        egoId: 104,
        lastChatAt: DateTime.now().subtract(Duration(hours: 5)),
        isDeleted: false,
        egoName: '준호',
        profileImage: 'assets/image/ego_icon.png',
      ),
      ChatRoomModel(
        id: 5,
        uid: 'user345',
        egoId: 105,
        lastChatAt: DateTime.now().subtract(Duration(hours: 6)),
        isDeleted: false,
        egoName: '하늘',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 6,
        uid: 'user678',
        egoId: 106,
        lastChatAt: DateTime.now().subtract(Duration(hours: 7)),
        isDeleted: false,
        egoName: '태윤',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 7,
        uid: 'user901',
        egoId: 107,
        lastChatAt: DateTime.now().subtract(Duration(hours: 8)),
        isDeleted: false,
        egoName: '미소',
        profileImage: 'assets/image/ego_icon.png',
      ),
      ChatRoomModel(
        id: 8,
        uid: 'user234',
        egoId: 108,
        lastChatAt: DateTime.now().subtract(Duration(hours: 9)),
        isDeleted: false,
        egoName: '유리',
        profileImage: 'assets/image/ego_icon.png',
      ),
      ChatRoomModel(
        id: 9,
        uid: 'user567',
        egoId: 109,
        lastChatAt: DateTime.now().subtract(Duration(hours: 10)),
        isDeleted: false,
        egoName: '진우',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 10,
        uid: 'user890',
        egoId: 110,
        lastChatAt: DateTime.now().subtract(Duration(hours: 11)),
        isDeleted: false,
        egoName: '아라',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 11,
        uid: 'user112',
        egoId: 111,
        lastChatAt: DateTime.now().subtract(Duration(hours: 12)),
        isDeleted: false,
        egoName: '사과',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 12,
        uid: 'user223',
        egoId: 112,
        lastChatAt: DateTime.now().subtract(Duration(days: 2)),
        isDeleted: false,
        egoName: '바나나',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 13,
        uid: 'user334',
        egoId: 113,
        lastChatAt: DateTime.now().subtract(Duration(days: 5)),
        isDeleted: false,
        egoName: '옥수수',
        profileImage: 'assets/image/ego_1.png',
      ),
      ChatRoomModel(
        id: 14,
        uid: 'user445',
        egoId: 114,
        lastChatAt: DateTime.now().subtract(Duration(days: 10)),
        isDeleted: false,
        egoName: '옥바바',
        profileImage: 'assets/image/ego_icon.png',
      ),
    ];

    // 추후 API 요청 로직
    // fetchChatRooms();
  }

  // Future<void> fetchChatRooms() async {
  //   final data = await YourApiService.getChatRooms();
  //   setState(() {
  //     _chatRoomList = data;
  //   });
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
                  builder: (context) => ChatRoomScreen(
                    chatRoomId: chat.id,
                    uid: chat.uid,
                  ),
                ),
              );

            },
            onLongPress: () async {
              final result = await showConfirmDialog(
                context: context,
                title: '채팅방을 나가시겠어요?',
                content: '${chat.egoName} 채팅방에서 나가면 대화 내용이 삭제됩니다.',
                dialogType: DialogType.info,
                stack: true,
                cancelText: '취소',
                confirmText: '나가기',
                confirmBackgroundColor: AppColors.red,
                confirmForegroundColor: AppColors.white,
                confirmOverlayColor: AppColors.white,
              );

              if (result == true) {
                setState(() {
                  _chatRoomList.removeWhere((element) => element.id == chat.id);
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  buildEgoListItem(
                    chat.profileImage ?? 'assets/image/ego_icon.png',
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
                              chat.egoName ?? '이름 없음',
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
                          '자기소개 또는 최근 메시지',
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
