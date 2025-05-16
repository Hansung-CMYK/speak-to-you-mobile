import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupChatBubble extends StatelessWidget {
  final ChatHistory message;
  final VoidCallback onDelete;

  const GroupChatBubble({
    required this.message,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == "user";
    final alignment = isUser ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h), // vertical 간격 늘림
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: GestureDetector(
              onLongPress: () async {
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
                  onDelete();
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16), // 둥근 모서리
                child: SvgPicture.asset(
                  message.content,
                  width: 120.w, // 크기 줄임
                  height: 120.h,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => Container(
                    width: 120.w,
                    height: 120.h,
                    color: Colors.grey.shade200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}