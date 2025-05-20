import 'dart:convert';
import 'dart:typed_data';

import 'package:ego/models/chat/firebase_chat_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/confirm_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class GroupChatBubble extends StatelessWidget {
  final FirebaseChatModel chatModel;
  final VoidCallback onDelete;
  final VoidCallback onProfileTap;
  final bool isMe;

  const GroupChatBubble({
    required this.chatModel,
    required this.onDelete,
    required this.onProfileTap,
    required this.isMe
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    Uint8List? profileImageBytes; // 보낸 사용자의 ego profile Image

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) // 왼쪽 프로필
            GestureDetector(
              onTap: onProfileTap,
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: profileImageBytes != null
                      ? MemoryImage(profileImageBytes)
                      : null,
                  child: profileImageBytes == null
                      ? Icon(Icons.person, size: 16.sp, color: Colors.white)
                      : null,
                ),
              ),
            ),

          // 채팅 내용 (SVG 이미지)
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
                borderRadius: BorderRadius.circular(16),
                child: SvgPicture.asset(
                  chatModel.text, // 그룹채팅의 이모지 경로
                  width: 120.w,
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
