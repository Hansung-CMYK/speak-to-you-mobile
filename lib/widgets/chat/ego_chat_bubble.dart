import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 채팅 내역 하나를 표시하는 ChatBubble 위젯
 *
 * @param message - ChatHistory
 * @param previousMessage - 이전 채팅 메시지 (연속 여부 판단 등 레이아웃 처리에 사용)
 * @param nextMessage - 다음 채팅 메시지 (연속 여부 판단 등 레이아웃 처리에 사용)
 * @param onDelete - 사용자가 메시지를 삭제할 때 호출되는 콜백 함수
 */
class ChatBubble extends StatelessWidget {
  final ChatHistory message;
  final ChatHistory? previousMessage;
  final ChatHistory? nextMessage;
  final VoidCallback onDelete;

  const ChatBubble({
    required this.message,
    this.previousMessage,
    this.nextMessage,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == "u";

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
    final bubbleColor = isUser ? AppColors.accent : AppColors.white;
    final textColor = isUser ? AppColors.white : AppColors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isUser)
            Padding(
              padding: EdgeInsets.only(right: 4),
              child: Text(
                message.formattedChatAt,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
          Flexible(
            child: GestureDetector(
              onLongPress:
                  isUser // user인 경우만 삭제 할 수 있음
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
                  message.content,
                  style: TextStyle(fontSize: 15.sp, color: textColor),
                ),
              ),
            ),
          ),
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                message.formattedChatAt,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
