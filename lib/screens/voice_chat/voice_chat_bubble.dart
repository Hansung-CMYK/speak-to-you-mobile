import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/chat/chat_history_model.dart';
import '../../theme/color.dart';

class VoiceChatBubble extends StatelessWidget {
  final ChatHistory message;
  final ChatHistory? previousMessage;
  final ChatHistory? nextMessage;

  const VoiceChatBubble({
    Key? key,
    required this.message,
    this.previousMessage,
    this.nextMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == "U";
    final bool sameAsPrevious = previousMessage?.type == message.type;
    final bool sameAsNext = nextMessage?.type == message.type;

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
    final bubbleColor = (isUser ? AppColors.accent : AppColors.white).withOpacity(0.75);
    final textColor = isUser ? AppColors.white : AppColors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: bubbleRadius,
              ),
              child: Text(
                message.content,
                style: TextStyle(fontSize: 15.sp, color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
