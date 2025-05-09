import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/chat/chat_history_model.dart';
import 'chat_bubble.dart';

class ChatRoomScreen extends StatefulWidget {
  final int chatRoomId;
  final String uid;

  const ChatRoomScreen({Key? key, required this.chatRoomId, required this.uid})
    : super(key: key);

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

        //TODO 채팅 내역 전송 API

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
      appBar: AppBar(title: Text("보글보글 캘라몬")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 8),
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
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: SafeArea(
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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Color(0xFF6750A4)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
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
        ],
      ),
    );
  }
}
