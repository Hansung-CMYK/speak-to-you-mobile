import 'package:ego/screens/voice_chat/voice_chat_bubble.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';

import 'package:ego/models/chat/chat_history_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceChatOverlay extends StatelessWidget {
  final List<ChatHistory> chatHistories;
  final double height;

  const VoiceChatOverlay({
    Key? key,
    required this.chatHistories,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.h),
      height: height,
      width: double.infinity,
      color: AppColors.transparent,
      child: ListView.builder(
        itemCount: chatHistories.length,
        itemBuilder: (context, index) {
          final chat = chatHistories[index];
          final previous = index > 0 ? chatHistories[index - 1] : null;
          final next =
              index < chatHistories.length - 1
                  ? chatHistories[index + 1]
                  : null;

          return VoiceChatBubble(
            message: chat,
            previousMessage: previous,
            nextMessage: next,
          );
        },
      ),
    );
  }
}
