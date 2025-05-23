import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ego/models/chat/firebase_chat_model.dart';

class HumanChatBubble extends StatelessWidget {
  final FirebaseChatModel message;
  final FirebaseChatModel? previousMessage;
  final FirebaseChatModel? nextMessage;
  final VoidCallback onDelete;
  final bool isMe;

  const HumanChatBubble({
    required this.message,
    this.previousMessage,
    this.nextMessage,
    required this.onDelete,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final bool sameAsPrevious = previousMessage?.senderId == message.senderId;
    final bool sameAsNext = nextMessage?.senderId == message.senderId;

    final Radius radius = Radius.circular(16);

    BorderRadius bubbleRadius;

    if (isMe) {
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

    final alignment = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bubbleColor = isMe ? AppColors.humanChatColor : AppColors.white;
    final textColor = isMe ? AppColors.black : AppColors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMe)
            Padding(
              padding: EdgeInsets.only(right: 4),
              child: Text(
                message.formattedTime,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
          Flexible(
            child: GestureDetector(
              onLongPress: // 내채팅만 삭제가 가능함
                  isMe
                      ? () async {
                        final result = await showConfirmDialog(
                          context: context,
                          title: '메시지를 삭제할까요?',
                          content: '삭제하면 이 메시지는 다시 볼 수 없어요.',
                          dialogType: DialogType.info,
                          stack: true,
                          cancelText: '취소',
                          confirmText: '삭제',
                          confirmBackgroundColor: AppColors.red,
                          confirmForegroundColor: AppColors.white,
                          confirmOverlayColor: AppColors.white,
                        );

                        if (result == true) {
                          onDelete(); // 삭제 콜백 호출
                        }
                      }
                      : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: bubbleRadius,
                ),
                child: Text(
                  message.text,
                  style: TextStyle(fontSize: 15.sp, color: textColor),
                ),
              ),
            ),
          ),
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                message.formattedTime,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
