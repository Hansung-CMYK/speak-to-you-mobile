import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ego/models/chat/chat_room_list_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';

import '../../providers/chat/chat_room_list_provider.dart';
import 'chat_room_screen.dart';

/**
 * 채팅방 리스트를 확인하는 화면
 * */
class ChatListScreen extends ConsumerStatefulWidget  {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ChatRoomListModel> _chatRoomList = [];
  int? _selectedChatRoomId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);


    fetchChatRooms();
  }

  Future<void> fetchChatRooms() async {
    final data = await ref.read(chatRoomListModelProvider("test").future);
    setState(() {
      _chatRoomList = data;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        thumbVisibility: true,
        thickness: 3,
        thumbColor: AppColors.gray700,
        radius: Radius.circular(10.r),
        child: ListView.builder(
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
                        (context) => ChatRoomScreen(
                          chatRoomId: chat.id,
                          uid: chat.uid,
                          egoProfileImage:
                              chat.profileImage ?? "assets/image/ego_icon.png",
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
