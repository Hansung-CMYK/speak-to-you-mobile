import 'package:ego/theme/color.dart';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/widgets/chat/emoji_send_btn.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'chat_bubble.dart';

class GroupChatRoomScreen extends StatefulWidget {
  final int chatRoomId;
  final String uid;
  final String personalityTagName;

  const GroupChatRoomScreen({
    Key? key,
    required this.chatRoomId,
    required this.uid,
    required this.personalityTagName,
  }) : super(key: key);

  @override
  _GroupChatRoomScreenState createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  late FToast fToast;
  final customToast = CustomToast(
    toastMsg: "삭제 오류",
    backgroundColor: AppColors.red,
    fontColor: AppColors.white,
  );

  late FocusNode _focusNode;

  final ScrollController _scrollController = ScrollController();

  late List<ChatHistory> messages = [];
  bool _isEmojiVisible = false;

  int _pageNum = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _fetchInitialData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 200 && !_isLoading && _hasMore) {
        _fetchMoreData();
      }
    });

    _focusNode = FocusNode();
  }

  Future<void> _fetchInitialData() async {
    // 그룹채팅 리스트 불러오기
  }

  Future<void> _fetchMoreData() async {}

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 이미지 경로 전송 로직
  void _sendMessage(String content) {
    //uid는 시스템에 존재
    ChatHistory chatHistory = ChatHistory(
      uid: 'test',
      chatRoomId: widget.chatRoomId,
      content: content,
      type: 'U',
      chatAt: DateTime.now(),
    );

    //TODO 전송 로직

    setState(() {
      messages.insert(0, chatHistory);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        title: Text(
          "${widget.personalityTagName}",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        surfaceTintColor: AppColors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: RawScrollbar(
                  thumbVisibility: true,
                  thickness: 3,
                  thumbColor: AppColors.gray700,
                  radius: Radius.circular(10.r),
                  controller: _scrollController,
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final previous =
                          index < messages.length - 1
                              ? messages[index + 1]
                              : null;
                      final next = index > 0 ? messages[index - 1] : null;

                      return ChatBubble(
                        message: messages[index],
                        previousMessage: previous,
                        nextMessage: next,
                        onDelete: () async {
                          try {
                            setState(() {
                              messages.removeAt(index);
                            });
                            _focusNode.unfocus();
                          } catch (e) {
                            customToast.init(fToast);
                            customToast.showTopToast();
                          }
                        },
                      );
                    },
                  ),
                ),
              ),

              // 이모지 보이기 버튼
              buildEmojiSendBtn(
                isPressed: _isEmojiVisible,
                onPressed: () {
                  setState(() {
                    _isEmojiVisible = !_isEmojiVisible;
                  });
                },
              ),
            ],
          ),

          // 이모지 패널
          Align(
            alignment: Alignment.bottomCenter,
            child:
                _isEmojiVisible
                    ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 67),
                      decoration: BoxDecoration(
                        color: Color(0x99414141),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: _showEmojiList(_sendMessage),
                    )
                    : SizedBox.shrink(),
          ),

          // 뒤 배경 클릭시 이모지 패널 닫기 위한 반투명 영역
          if (_isEmojiVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              // 이모지 패널 높이만큼 위에서 끝남 (예: 200 + margin/padding 고려해서 220)
              bottom: 280,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isEmojiVisible = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

Widget _showEmojiList(void Function(String) onPressed) {
  List<String> emojiList = [
    'assets/icon/emotion/anger.svg',
    'assets/icon/emotion/happiness.svg',
    'assets/icon/emotion/sadness.svg',
    'assets/icon/emotion/embarrassment.svg',
    'assets/icon/emotion/disappointment.svg',
  ];

  return Container(
    height: 200,
    margin: EdgeInsets.only(right: 12, left: 12, top: 12),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
    ),
    child: GridView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: emojiList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(index);
            //uid는 시스템에 존재

            onPressed(emojiList[index]);
          },
          child: SvgPicture.asset(emojiList[index], width: 40, height: 40),
        );
      },
    ),
  );
}
