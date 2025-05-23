import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/models/ego_info_model.dart';
import 'package:ego/screens/voice_chat/call_time_banner.dart';
import 'package:ego/screens/voice_chat/voice_chat_overlay.dart';
import 'package:ego/theme/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat_history_screen.dart';

class VoiceChatScreen extends StatefulWidget {
  final EgoInfoModel egoInfoModel;
  final String uid;

  const VoiceChatScreen({
    Key? key,
    required this.egoInfoModel,
    required this.uid,
  }) : super(key: key);

  @override
  _VoiceChatScreenState createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isChatVisible = false;

  final double iconWidth = 35;
  final double iconHeight = 35;

  late List<ChatHistory> chatHistoryList;

  @override
  void initState() {
    super.initState();
    // 임시 데이터
    chatHistoryList = [
      ChatHistory(
        uid: "user1",
        chatRoomId: 1,
        content: "방가방가",
        type: "ego",
        chatAt: DateTime.parse("2025-05-09 09:21:00.000"),
        isDeleted: false,
        contentType: "TEXT"
      ),
      ChatHistory(
        uid: "user1",
        chatRoomId: 1,
        content: "오늘은 어떤일이 있었어?",
        type: "ego",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
        contentType: "TEXT"
      ),
      ChatHistory(
        uid: widget.uid,
        chatRoomId: 1,
        content: "블라블라 오늘도 블라블르라",
        type: "user",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
        contentType: "TEXT"
      ),
      ChatHistory(
        uid: widget.uid,
        chatRoomId: 1,
        content: "블라블라 오늘도 블라블르라",
        type: "user",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
        contentType: "TEXT"
      ),
      ChatHistory(
        uid: widget.uid,
        chatRoomId: 1,
        content: "블라블라 오늘도 블라블르라",
        type: "user",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
        contentType: "TEXT"
      ),
      ChatHistory(
        uid: widget.uid,
        chatRoomId: 1,
        content: "블라블라 오늘도 블라블르라",
        type: "user",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
        contentType: "TEXT"
      ),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addChat(ChatHistory chat) {
    setState(() {
      chatHistoryList.add(chat);
    });
    // 채팅이 추가된 후에 스크롤을 마지막으로 이동
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    EgoInfoModel egoInfo = widget.egoInfoModel;
    String uid = widget.uid;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppColors.darkCharcoal,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 좌측 Icons
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    isMicOn
                        ? 'assets/icon/mic_on.svg'
                        : 'assets/icon/mic_off.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isMicOn = !isMicOn;
                      _addChat(
                        ChatHistory(
                          uid: "some-uid",
                          chatRoomId: 1,
                          content: "자동 추가된 메시지",
                          type: "user",
                          chatAt: DateTime.now(),
                          isDeleted: false,
                          contentType: "TEXT"
                        ),
                      );
                    });
                  },
                ),
                SizedBox(width: 25.w),
                IconButton(
                  icon: SvgPicture.asset(
                    isSpeakerOn
                        ? 'assets/icon/sound_on.svg'
                        : 'assets/icon/sound_off.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isSpeakerOn = !isSpeakerOn;
                    });
                  },
                ),
              ],
            ),

            // 우측 Icons
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icon/chat_history.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatHistoryScreen(
                          chatHistories: chatHistoryList,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 25.w),
                IconButton(
                  icon: SvgPicture.asset(
                    isChatVisible
                        ? 'assets/icon/disappear_chat.svg'
                        : 'assets/icon/appear_chat.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isChatVisible = !isChatVisible;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: const _LowerCenterDockedFabLocation(),
      floatingActionButton: CallEndButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: TopCallTimeBanner(egoName: egoInfo.egoName),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Image.asset(
                      'assets/image/ego_1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isChatVisible)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VoiceChatOverlay(
                      chatHistories: chatHistoryList,
                      height: 300.h,
                      scrollController: _scrollController,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/**
 * 실시간 대화 종료 버튼
 * */
class CallEndButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CallEndButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65.w,
      height: 65.h,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.call_end, size: 36.0, color: AppColors.white),
      ),
    );
  }
}

class _LowerCenterDockedFabLocation extends FloatingActionButtonLocation {
  const _LowerCenterDockedFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;

    final double fabY =
        scaffoldGeometry.contentBottom -
        (scaffoldGeometry.floatingActionButtonSize.height / 2) +
        20;

    return Offset(fabX, fabY);
  }
}
