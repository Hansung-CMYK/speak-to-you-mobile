import 'package:ego/theme/color.dart';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/widgets/chat/chat_bubble.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 실시간 대화에서 나누었던 대화 기록을 한번에 확인하기 위함
 * */
class ChatHistoryScreen extends StatefulWidget {
  final List<ChatHistory> chatHistories;

  const ChatHistoryScreen({Key? key, required this.chatHistories})
    : super(key: key);

  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  late List<ChatHistory> messages;

  @override
  void initState() {
    super.initState();
    messages = widget.chatHistories;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        title: Text(
          "대화기록",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        surfaceTintColor: AppColors.white,
        centerTitle: true,
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
                    onDelete: () {},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
