import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:ego/models/chat/chat_topic_model.dart';
import 'package:ego/screens/change_topic/showChatHistoryPopup.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/confirm_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 주제변경화면
///
/// chatHistory : 주제와 대화내역을 가지는 Model List를 전달 받습니다. [ChatTopicModel]
/// isFinalEdit : 최종 일기 작성전 주제변경인지 확인합니다. [bool]
class ChangeTopicScreen extends StatefulWidget {
  final List<ChatTopicModel> chatHistory;
  final bool isFinalEdit;

  const ChangeTopicScreen({
    super.key,
    required this.chatHistory,
    required this.isFinalEdit,
  });

  @override
  State<ChangeTopicScreen> createState() => _ChangeTopicScreenState();
}

class _ChangeTopicScreenState extends State<ChangeTopicScreen> {
  void _showPopup(BuildContext context, String topic) {
    // 주제에 해당하는 채팅 기록을 가져옴
    final chatMessages =
        widget.chatHistory
            .firstWhere((topicModel) => topicModel.mainTopic == topic)
            .chats;

    showDialog(
      context: context,
      barrierColor: Colors.white.withValues(alpha: 0.0),
      builder: (context) => showChatHistoryPopup(context, topic, chatMessages),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: '주제변경'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 페이지 제목 부분
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나는오늘!',
                  style: TextStyle(
                    color: AppColors.gray900,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '이야기 중인 대화 주제를 변경할 수 있어요.',
                  style: TextStyle(
                    color: AppColors.gray600,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 리스트뷰 부분
          Expanded(
            child: RawScrollbar(
              thumbVisibility: true,
              thickness: 6.w,
              radius: Radius.circular(10.r),
              thumbColor: AppColors.gray700,
              padding: EdgeInsets.only(right: 2.w),
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = widget.chatHistory.removeAt(oldIndex);
                    widget.chatHistory.insert(newIndex, item);
                  });
                },
                proxyDecorator: (child, index, animation) {
                  return Opacity(
                    opacity: 0.8,
                    child: child,
                  );
                },
                children: [
                  for (
                    int index = 0;
                    index < widget.chatHistory.length;
                    index++
                  )
                    Dismissible(
                      key: ValueKey(widget.chatHistory[index]),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        var deletedItem = widget.chatHistory[index];

                        setState(() {
                          widget.chatHistory.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${deletedItem.mainTopic} 삭제됨'),
                          ),
                        );
                      },
                      background: Container(
                        color: AppColors.gray700,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icon/trash.svg'),
                            SizedBox(height: 2.h),
                            Text(
                              '삭제',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Material(
                        child: Builder(
                          builder: (context) {
                            final chatItem = widget.chatHistory[index];
                            final canWriteDiary = chatItem.canWriteDiary;

                            return Container(
                              key: ValueKey(chatItem),
                              decoration: BoxDecoration(
                                color:
                                    canWriteDiary
                                        ? AppColors.deepPrimary
                                        : AppColors.white,
                                border: Border(
                                  top: BorderSide(
                                    color:
                                        canWriteDiary
                                            ? AppColors.white
                                            : AppColors.gray200,
                                    width: 0.5.h,
                                  ),
                                  bottom: BorderSide(
                                    color:
                                        canWriteDiary
                                            ? AppColors.white
                                            : AppColors.gray200,
                                    width: 0.5.h,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading:
                                    canWriteDiary
                                        ? SvgPicture.asset(
                                          'assets/icon/draggable_white_icon.svg',
                                        )
                                        : SvgPicture.asset(
                                          'assets/icon/draggable_icon.svg',
                                        ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (chatItem.reason != null &&
                                            !chatItem.canWriteDiary)
                                          Blur(
                                            blur: 1.5,
                                            blurColor: AppColors.white,
                                            child: Text(
                                              "${chatItem.reason!} ",
                                              style: TextStyle(
                                                color: AppColors.gray900,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        Text(
                                          chatItem.mainTopic,
                                          style: TextStyle(
                                            color:
                                                canWriteDiary
                                                    ? AppColors.gray100
                                                    : AppColors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      chatItem.subTopic,
                                      style: TextStyle(
                                        color:
                                            canWriteDiary
                                                ? AppColors.gray100
                                                : AppColors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                onTap:
                                    () =>
                                        _showPopup(context, chatItem.mainTopic),
                              ),
                            );
                          },
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        bool? confirmed = await showConfirmDialog(
                          context: context,
                          title: '주제를 삭제할까요?',
                          content: '선택한 대화 주제가 기록에서 사라집니다.',
                          dialogType: DialogType.info,
                          confirmText: '확인',
                          cancelText: '취소',
                        );

                        return confirmed ?? false;
                      },
                    ),
                ],
              ),
            ),
          ),

          // 일기 작성 확정 버튼
          if (widget.isFinalEdit)
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              width: double.infinity,
              child: TextButton(
                onPressed:
                    () => {
                      // TODO 일기 작성 요청보내고 수정 화면으로 넘어가기
                      widget.chatHistory.asMap().forEach((index, item) {
                        print('$index 번째: ${item.mainTopic}');
                      }),
                    },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.deepPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                ),
                child: Text(
                  "저장하고 일기 만들기",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
