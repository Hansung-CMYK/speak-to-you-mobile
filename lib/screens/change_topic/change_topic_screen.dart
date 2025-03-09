import 'package:ego/models/chat/chat_content_model.dart';
import 'package:ego/models/chat/chat_topic_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/alert_dialog.dart';
import 'package:ego/widgets/appbar/stack_app_bar.dart';
import 'package:ego/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChangeTopicScreen extends StatefulWidget {
  final List<ChatTopicModel> chatHistory;

  const ChangeTopicScreen({super.key, required this.chatHistory});

  @override
  State<ChangeTopicScreen> createState() => _ChangeTopicScreenState();
}

class _ChangeTopicScreenState extends State<ChangeTopicScreen> {
  void _showPopup(BuildContext context, String topic) {
    // 주제에 해당하는 채팅 기록을 가져옴
    final chatMessages =
        widget.chatHistory
            .firstWhere((topicModel) => topicModel.topic == topic)
            .chats;

    showDialog(
      context: context,
      barrierColor: Colors.white.withValues(alpha: 0.0),
      builder: (context) => showFullScreenPopup(context, topic, chatMessages),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StackAppBar(title: '주제변경'),
      body: ReorderableListView(
        children: [
          for (int index = 0; index < widget.chatHistory.length; index++)
            Dismissible(
              key: ValueKey(widget.chatHistory[index].topic),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // 삭제할 아이템을 저장
                var deletedItem = widget.chatHistory[index];

                setState(() {
                  // 삭제된 아이템 처리
                  widget.chatHistory.removeAt(index);
                });

                // 삭제 완료 후 알림
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${deletedItem.topic} 삭제됨')),
                );
              },

              background: Container(
                color: Colors.red, // 슬라이드 시 배경 색상
                alignment: Alignment.centerRight, // 삭제 아이콘을 오른쪽 끝에 배치
                padding: EdgeInsets.only(right: 20), // 오른쪽 여백 설정
                child: Icon(Icons.delete, color: Colors.white), // 삭제 아이콘
              ),

              // topic Item
              child: ListTile(
                key: ValueKey(widget.chatHistory[index].topic),
                leading: Icon(Icons.drag_handle),
                title: Text(widget.chatHistory[index].topic),
                onTap:
                    () => _showPopup(context, widget.chatHistory[index].topic),
              ),
              confirmDismiss: (direction) async {
                // 슬라이드 끝까지 밀었을 때 확인 콜백
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
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = widget.chatHistory.removeAt(oldIndex);
            widget.chatHistory.insert(newIndex, item);
          });
        },
      ),
    );
  }
}

/// 클릭한 주제의 내용을 표시하는 풀스크린 팝업 위젯 반환
Widget showFullScreenPopup(
  BuildContext context,
  String topic,
  List<ChatContentModel> chatMessages,
) {
  // 시간 순으로 정렬
  chatMessages.sort((a, b) => a.time.compareTo(b.time));

  return Dialog(
    insetPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.8)),
      child: Stack(
        children: [
          // 팝업 내용 중앙 배치
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 선택한 주제 표시
                Text(
                  topic,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // 채팅방 내용
                Expanded(
                  child: RawScrollbar(
                    thumbVisibility: true,
                    thumbColor: AppColors.gray700,
                    radius: Radius.circular(10.r),
                    thickness: 4.w,
                    padding: EdgeInsets.only(right: 2.w),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children:
                          chatMessages.map((message) {
                            bool isUserMessage = message.isUser;
                            return Row(
                              mainAxisAlignment:
                                  isUserMessage
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      isUserMessage
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (!isUserMessage) ...[
                                          // 남이 보낸 메시지: 채팅 내용, 시간
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 250.w,
                                              ),
                                              child: Text(
                                                message.content,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            formatToAMPM(message.time),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ] else ...[
                                          // 내가 보낸 메시지: 시간, 채팅 내용
                                          Text(
                                            formatToAMPM(message.time),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 250.w,
                                              ),
                                              child: Text(
                                                message.content,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 닫기 버튼 우측 상단 배치
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(), // 닫기 버튼
                child: Text("닫기"),
              ),
            ),
          ),

          // '대화내역' 텍스트 좌측 상단 배치
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '대화내역',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String formatToAMPM(String dateStr) {
  DateTime dateTime = DateFormat('yyyy/MM/dd/HH:mm:ss').parse(dateStr);

  return DateFormat('aHH:mm').format(dateTime);
}

///TODO 확인 버튼 (순서 바뀌는 지 확인) - 2
///주제 작성 할 수 있는 것과 없는 것 디자인 - 1
/// 대화 내역보기 디자인 수정 - 1
