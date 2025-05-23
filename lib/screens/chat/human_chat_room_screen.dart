import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ego/models/chat/firebase_chat_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/chat/human_chat_bubble.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';

class HumanChatScreen extends StatefulWidget {
  final String egoName;
  final String otherUserId;

  const HumanChatScreen({
    super.key,
    required this.egoName,
    required this.otherUserId,
  });

  @override
  State<HumanChatScreen> createState() => _HumanChatScreenState();
}

class _HumanChatScreenState extends State<HumanChatScreen> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  late final String myUid;

  late FToast fToast;
  final customToast = CustomToast(
    toastMsg: "삭제 오류",
    backgroundColor: AppColors.red,
    fontColor: AppColors.white,
  );

  String get chatId {
    //uid는 시스템에 존재
    List<String> ids = [myUid, widget.otherUserId];
    ids.sort();
    return ids.join('_');
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(context);

    myUid = 'user_id_001'; //uid는 시스템에 존재
  }

  void _sendMessage() async {
    if (_textController.text.trim().isEmpty) return;

    final message = _textController.text;
    _textController.clear();

    // Auto scroll to bottom after sending
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // 파이어 스토어에 데이터 전달
    await FirebaseFirestore.instance
        .collection('chats/user_chat/${chatId}')
        .add({
          'text': message,
          'senderId': myUid,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        title: Text(
          '${widget.egoName}의 본체',
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        surfaceTintColor: AppColors.white,
      ),
      body: Column(
        children: [
          Expanded(
            // 직접 파이어 스토어에서 데이터를 가져오는 부분.(실시간 업데이트 포함)
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc('user_chat')
                      .collection('${chatId}')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      '대화를 시작해 보세요!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true, // Display latest messages at the bottom
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    // 현재 메시지
                    final currentMessageData =
                        messages[index].data() as Map<String, dynamic>;
                    final currentChat = FirebaseChatModel.fromMap(
                      currentMessageData,
                    );

                    // 이전 메시지 (index + 1)
                    FirebaseChatModel? previousChat;
                    if (index < messages.length - 1) {
                      final previousData =
                          messages[index + 1].data() as Map<String, dynamic>;
                      previousChat = FirebaseChatModel.fromMap(previousData);
                    }

                    // 다음 메시지 (index - 1)
                    FirebaseChatModel? nextChat;
                    if (index > 0) {
                      final nextData =
                          messages[index - 1].data() as Map<String, dynamic>;
                      nextChat = FirebaseChatModel.fromMap(nextData);
                    }

                    final isMe = currentMessageData['senderId'] == myUid;

                    return HumanChatBubble(
                      message: currentChat,
                      previousMessage: previousChat,
                      nextMessage: nextChat,
                      isMe: isMe,
                      onDelete: () async {
                        // uid는 시스템에 존재한다 가정
                        try {
                          // 메시지 삭제 요청
                          await FirebaseFirestore.instance
                              .collection('chats')
                              .doc('user_chat')
                              .collection(chatId)
                              .doc(messages[index].id) // 각 메시지 문서의 ID
                              .delete();

                          _focusNode.unfocus();
                        } catch (e) {
                          // 삭제 오류시 ToastMSG 생성
                          customToast.init(fToast);
                          customToast.showTopToast();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),

          // 입력창
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gray200, width: 2.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      backgroundColor: AppColors.accent,
                      child: IconButton(
                        icon: SvgPicture.asset("assets/icon/paper_plane.svg"),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
