import 'package:ego/models/chat/chat_history_kafka_model.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/providers/ego_provider.dart';
import 'package:ego/services/chat/chat_history_service.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:ego/services/websocket/chat_kafka_socket_service.dart';
import 'package:ego/widgets/bottomsheet/today_ego_introV2.dart';
import 'package:ego/widgets/chat/ego_chat_bubble.dart';

class EgoChatRoomScreen extends ConsumerStatefulWidget {
  final int chatRoomId;
  final String uid;
  final EgoModelV2 egoModel;

  const EgoChatRoomScreen({
    Key? key,
    required this.chatRoomId,
    required this.uid,
    required this.egoModel,
  }) : super(key: key);

  @override
  _EgoChatRoomScreenState createState() => _EgoChatRoomScreenState();
}

class _EgoChatRoomScreenState extends ConsumerState<EgoChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final SocketService _socketService = SocketService();

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

    _focusNode = FocusNode();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 200 && !_isLoading && _hasMore) {
        _fetchMoreData();
      }
    });

    // ✅ 연결 시 메시지 수신 처리
    _socketService.onMessageReceived((message) {
      setState(() {
        messages.insert(0, ChatHistoryKafka.convertToChatHistory(message));
      });
    });

    // ✅ 실제 연결
    //uid는 시스템에 존재
    _socketService.connect(uid: widget.uid);
  }

  Future<void> _fetchInitialData() async {
    setState(() => _isLoading = true);
    final chatHistories = await ChatHistoryService.fetchChatHistoryList(
      uid: widget.uid,
      pageNum: _pageNum,
      pageSize: 15,
      chatRoomId: widget.chatRoomId,
    );
    if (chatHistories.isEmpty) {
      setState(() => _hasMore = false);
    } else {
      setState(() {
        messages.addAll(chatHistories);
        _pageNum++;
      });
    }
    setState(() => _isLoading = false);
  }

  Future<void> _fetchMoreData() async {
    setState(() => _isLoading = true);
    final chatHistories = await ChatHistoryService.fetchChatHistoryList(
      uid: widget.uid,
      pageNum: _pageNum,
      pageSize: 15,
      chatRoomId: widget.chatRoomId,
    );
    if (chatHistories.isEmpty) {
      setState(() => _hasMore = false);
    } else {
      setState(() {
        messages.addAll(chatHistories);
        _pageNum++;
      });
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _socketService.disconnect();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    final hashInput = "${widget.uid}|$formattedDate|$text";
    final messageHash = ChatHistory.generateSHA256(hashInput);

    final inputMessage = ChatHistory(
      //uid는 시스템에 존재
      uid: widget.uid,
      chatRoomId: widget.chatRoomId,
      content: text,
      type: "u",
      chatAt: now,
      isDeleted: false,
      messageHash: messageHash,
      contentType: 'TEXT', // 일단 이미지 없이 text 채팅만 가능하도록 가정
    );

    final kafkaReqMessage = ChatHistory.convertToKafka(
      inputMessage,
      to: "1", // TODO 이후 수정 widget.egoModel.id.toString(),
      contentType: "TEXT",
    );

    _socketService.sendMessage(kafkaReqMessage);

    setState(() {
      messages.insert(0, inputMessage);
      _controller.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        title: Text(
          "${widget.egoModel.name}",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        actions: [
          // 우상단 ego profile 이미지
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: buildEgoListItem(widget.egoModel.profileImage, () {
              final egoAsync = ref.watch(
                  egoByIdProviderV2(widget.egoModel.id!));

              egoAsync.when(
                  data: (ego) {
                    showTodayEgoIntroSheetV2(this.context, ego);
                  },
                  error: (error, stack) {
                    print('에러 발생: $error');
                    print('스택트레이스: $stack');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // 프로바이더 새로고침
                              ref.invalidate(egoByIdProviderV2);
                            },
                            child: Text('다시 시도'),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator())
              );
            }, radius: 17),
          ),
        ],
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
                        await ChatHistoryService.deleteChatMessage(
                            uid: widget.uid,
                            messageHash: messages[index].messageHash!,
                        );

                        setState(() { // 삭제요청을 보낸 부분채팅부터 최신 대화까지 삭제
                          messages.removeRange(0, index + 1);
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
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
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
