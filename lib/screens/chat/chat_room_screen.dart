import 'package:ego/models/ego_info_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/widgets/bottomsheet/today_ego_intro.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat_bubble.dart';

// 초기 데이터 fetch
// spring에서 불러온 채팅 내용은 ChatHistory의 형식을 따른다.
// 송신
// 입력 받은 채팅을 ChatHistory의 형식으로 리스트에 저장한다.
// 입력 받은 채팅 내용은 ChatHistoryKafka의 형식으로 Kafka에 보낸다.
// 문제점 : 채팅 기록을 삭제하고 싶으면 ChatHistory의 id값을 알아야하는데 FE에서 알 수 없음
// 해결방법 : 카프카로 hash값을 전달한다.
// 수신
// kafka에서 받은 ChatHistoryKafka 데이터를 ChatHistory로 바꾼다.
// 리스트에 추가한다.
class ChatRoomScreen extends StatefulWidget {
  final int chatRoomId;
  final String uid;
  final String egoProfileImage;

  const ChatRoomScreen({
    Key? key,
    required this.chatRoomId,
    required this.uid,
    required this.egoProfileImage,
  }) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode;

  final ScrollController _scrollController = ScrollController();

  late List<ChatHistory> messages;

  @override
  void initState() {
    super.initState();
    // 테스트용 초기 메시지
    messages = [
      ChatHistory(
        id: 1,
        uid: "user1",
        chatRoomId: widget.chatRoomId,
        content: "방가방가",
        type: "E",
        chatAt: DateTime.parse("2025-05-09 09:21:00.000"),
        isDeleted: false,
      ),
      ChatHistory(
        id: 2,
        uid: "user1",
        chatRoomId: widget.chatRoomId,
        content: "오늘은 어떤일이 있었어?",
        type: "E",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
      ),
      ChatHistory(
        id: 3,
        uid: widget.uid,
        chatRoomId: widget.chatRoomId,
        content: "블라블라 오늘도 블라블르라",
        type: "U",
        chatAt: DateTime.parse("2025-05-09 09:20:00.000"),
        isDeleted: false,
      ),
    ];
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(
          ChatHistory(
            id: messages.length + 1,
            uid: widget.uid,
            chatRoomId: widget.chatRoomId,
            content: _controller.text,
            type: "U",
            chatAt: DateTime.now(),
            isDeleted: false,
          ),
        );

        //TODO 채팅 내역 Kafka로 바꾸기
        //TODO 채팅 내역 Kafka 전송 API

        _controller.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        title: Text(
          "보글보글 캘라몬",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: buildEgoListItem(widget.egoProfileImage, () {
              //TODO EGO ID로 EGO 정보 요청

              EgoInfoModel egoInfoModel = EgoInfoModel(
                id: "a",
                egoIcon: "assets/image/ego_icon.png",
                egoName: "사과",
                egoBirth: "2005/05/05",
                egoPersonality: "활발함",
                egoSelfIntro: "히히 사과 좋아",
              );

              showTodayEgoIntroSheet(this.context, egoInfoModel);
            }, radius: 17),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RawScrollbar(
              thumbVisibility: true,
              thickness: 3,
              thumbColor: AppColors.gray700,
              radius: Radius.circular(10.r),
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final previous = index > 0 ? messages[index - 1] : null;
                  final next =
                      index < messages.length - 1 ? messages[index + 1] : null;

                  return ChatBubble(
                    message: messages[index],
                    previousMessage: previous,
                    nextMessage: next,
                    onDelete: () {
                      setState(() {
                        messages.removeAt(index);
                      });
                      _focusNode.unfocus();

                      //TODO 삭제 요청
                    },
                  );
                },
              ),
            ),
          ),

          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gray200, width: 2.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      backgroundColor: AppColors.accent,
                      child: IconButton(
                        icon: SvgPicture.asset("assets/icon/paper_plane.svg"),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
