import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import '../../models/chat/chat_history_model.dart';

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
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray200,
      appBar: AppBar(title: Text("보글보글 캘라몬")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "생각보다 괜찮은 하루였어! 아침에",
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
                    backgroundColor: Color(0xFF6750A4),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
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

class ChatBubble extends StatelessWidget {
  final ChatHistory message;
  final ChatHistory? previousMessage;
  final ChatHistory? nextMessage;

  const ChatBubble({
    required this.message,
    this.previousMessage,
    this.nextMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == "U";

    // 이전, 다음 메시지와 같은 타입인지 판단
    final bool sameAsPrevious = previousMessage?.type == message.type;
    final bool sameAsNext = nextMessage?.type == message.type;

    // 기본 반지름
    final Radius radius = Radius.circular(16);

    BorderRadius bubbleRadius;

    if (isUser) {
      bubbleRadius = BorderRadius.only(
        topLeft: radius,
        topRight: sameAsPrevious ? Radius.circular(5) : radius,
        bottomLeft: radius,
        bottomRight: sameAsNext ? Radius.circular(5) : radius,
      );
    } else {
      bubbleRadius = BorderRadius.only(
        topLeft: sameAsPrevious ? Radius.circular(5) : radius,
        topRight: radius,
        bottomLeft: sameAsNext ? Radius.circular(5) : radius,
        bottomRight: radius,
      );
    }

    final alignment = isUser ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bubbleColor = isUser ? AppColors.accent : AppColors.white;
    final textColor = isUser ? AppColors.white : AppColors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isUser)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                message.formattedChatAt,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: bubbleRadius,
              ),
              child: Text(
                message.content,
                style: TextStyle(fontSize: 15, color: textColor),
              ),
            ),
          ),
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                message.formattedChatAt,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
