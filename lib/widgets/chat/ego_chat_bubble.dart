import 'dart:convert';

import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';
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
    Key? key,
    required this.message,
    this.previousMessage,
    this.nextMessage,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == 'u';
    final sameAsPrev = previousMessage?.type == message.type;
    final sameAsNext = nextMessage?.type == message.type;

    // ---------- 공통 UI 계산 ----------
    final r = const Radius.circular(16);
    final align = isUser ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bg = isUser ? AppColors.accent : AppColors.white;
    final txtCol = isUser ? AppColors.white : AppColors.black;

    BorderRadius bubbleRadius = BorderRadius.only(
      topLeft: isUser ? r : (sameAsPrev ? const Radius.circular(5) : r),
      topRight: isUser ? (sameAsPrev ? const Radius.circular(5) : r) : r,
      bottomLeft: isUser ? r : (sameAsNext ? const Radius.circular(5) : r),
      bottomRight: isUser ? (sameAsNext ? const Radius.circular(5) : r) : r,
    );

    // ---------- 콘텐츠 위젯 ----------
    Widget contentWidget;
    bool isImage = message.contentType == 'IMAGE';
    if (isImage) {
      // Base64 or URL
      final data = message.content;
      final image =
          data.startsWith('http')
              ? Image.network(data, fit: BoxFit.cover)
              : Image.memory(base64Decode(data), fit: BoxFit.cover);

      // 이미지만 보이도록 ClipRRect 사용
      contentWidget = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.65.sw, // 가로 폭 제한 (화면 65%)
            maxHeight: 0.5.sh, // 세로 폭 제한 (화면 50%)
          ),
          child: image,
        ),
      );
    } else {
      contentWidget = Text(
        message.content,
        style: TextStyle(fontSize: 15.sp, color: txtCol),
      );
    }

    // ---------- 래퍼 ----------
    Widget bubble =
        isImage
            ? contentWidget // 이미지면 말풍선 없이 그대로
            : Container(
              decoration: BoxDecoration(color: bg, borderRadius: bubbleRadius),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: contentWidget,
            );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: align,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isUser) _timeText(message.formattedChatAt),
          Flexible(
            child: GestureDetector(
              onLongPress:
                  isUser
                      ? () async {
                        final ok = await showConfirmDialog(
                          context: context,
                          title: '메시지를 삭제할까요?',
                          content: '삭제하면 이 메시지는 다시 볼 수 없어요.',
                          dialogType: DialogType.info,
                          cancelText: '취소',
                          confirmText: '삭제',
                          confirmBackgroundColor: AppColors.red,
                          confirmForegroundColor: AppColors.white,
                        );
                        if (ok == true) onDelete();
                      }
                      : null,
              child: bubble,
            ),
          ),
          if (!isUser) _timeText(message.formattedChatAt),
        ],
      ),
    );
  }

  Widget _timeText(String text) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
  );
}
