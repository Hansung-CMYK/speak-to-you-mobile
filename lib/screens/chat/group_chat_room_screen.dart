import 'package:ego/models/chat/chat_history_kafka_model.dart';
import 'package:ego/models/ego_info_model.dart';
import 'package:ego/models/ego_model.dart';
import 'package:ego/services/chat/chat_history_service.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/widgets/bottomsheet/today_ego_intro.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../services/websocket/chat_kafka_socket_service.dart';
import 'chat_bubble.dart';

class GroupChatRoomScreen extends StatefulWidget {
  final int chatRoomId;
  final String uid;
  final String personalityTagName;

  const GroupChatRoomScreen({
    Key? key,
    required this.chatRoomId,
    required this.uid,
    required this.personalityTagName,
  }) : super(key: key);

  @override
  _GroupChatRoomScreenState createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  late FToast fToast;
  final customToast = CustomToast(
    toastMsg: "삭제 오류",
    backgroundColor: AppColors.red,
    fontColor: AppColors.white,
  );

  late FocusNode _focusNode;

  final ScrollController _scrollController = ScrollController();

  late List<ChatHistory> messages = [];

  int _pageNum = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _fetchInitialData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 200 && !_isLoading && _hasMore) {
        _fetchMoreData();
      }
    });

    _focusNode = FocusNode();
  }

  Future<void> _fetchInitialData() async {
    // 그룹채팅 리스트 불러오기
  }

  Future<void> _fetchMoreData() async {

  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 이미지 경로 전송 로직
  void _sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        title: Text(
          "${widget.personalityTagName}",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        surfaceTintColor: AppColors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: RawScrollbar(
              thumbVisibility: true,
              thickness: 3,
              thumbColor: AppColors.gray700,
              radius: Radius.circular(10.r),
              controller: _scrollController,
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final previous =
                      index < messages.length - 1 ? messages[index + 1] : null;
                  final next = index > 0 ? messages[index - 1] : null;

                  return ChatBubble(
                    message: messages[index],
                    previousMessage: previous,
                    nextMessage: next,
                    onDelete: () async {
                      // uid는 시스템에 존재한다 가정
                      try {
                        // 메시지 삭제 요청

                        setState(() {
                          messages.removeAt(index);
                        });
                        _focusNode.unfocus();
                      } catch (e) {
                        // 삭제 오류시 ToastMSG 생성
                        customToast.init(fToast);
                        customToast.showTopToast();
                      }
                    },
                  );
                },
              ),
            ),
          ),

          // 입력 필드 부분
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
