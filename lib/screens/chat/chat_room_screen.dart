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

// 초기 데이터 fetch
// spring에서 불러온 채팅 내용은 ChatHistory의 형식을 따른다.
// 송신
// 입력 받은 채팅을 ChatHistory의 형식으로 리스트에 저장한다.
// 입력 받은 채팅 내용은 ChatHistoryKafka의 형식으로 Kafka에 보낸다.
// 문제점 : 채팅 기록을 삭제하고 싶으면 ChatHistory의 id값을 알아야하는데 FE에서 알 수 없음
// 해결방법 : 카프카로 hash값을 전달한다.
// 수신
// kafka에서 받은 ChatHistoryKafka 데이터를 ChatHistory로 바꾼다.
// 리스트에 추가한다.
class ChatRoomScreen extends StatefulWidget {
  final int chatRoomId;
  final String uid;
  final EgoModel egoModel;

  const ChatRoomScreen({
    Key? key,
    required this.chatRoomId,
    required this.uid,
    required this.egoModel,
  }) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
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

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 200 && !_isLoading && _hasMore) {
        _fetchMoreData();
      }
    });

    _socketService.connect(
      onMessageReceived: (message) {
        setState(() {
          messages.insert(0, ChatHistoryKafka.convertToChatHistory(message));
        });
      },
      //uid는 시스템에 존재한다 가정
      uid: widget.uid,
    );

    _focusNode = FocusNode();
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
    if (_controller.text.isNotEmpty) {
      setState(() {
        final now = DateTime.now();
        final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

        final hashInput = "${widget.uid}|$formattedDate|${_controller.text}";
        final messageHash = ChatHistory.generateSHA256(hashInput);

        ChatHistory inputMessage = ChatHistory(
          uid: widget.uid,
          chatRoomId: widget.chatRoomId,
          content: _controller.text,
          type: "U",
          chatAt: DateTime.now(),
          isDeleted: false,
          messageHash: messageHash,
        );

        ChatHistoryKafka kafkaReqMessage = ChatHistory.convertToKafka(
          to: widget.egoModel.id.toString(),
          inputMessage,
          type: "TEXT"
        );

        _socketService.sendMessage(kafkaReqMessage);

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
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: buildEgoListItem(widget.egoModel.profileImage, () {
              //TODO showTodayEgoIntroSheet의 매개변수를 EgoModel로 변경

              EgoInfoModel egoInfoModel = EgoInfoModel(
                id: "a",
                egoIcon: "assets/image/ego_icon.png",
                egoName: "사과",
                egoBirth: "2005/05/05",
                egoPersonality: "활발함",
                egoSelfIntro: "히히 사과 좋아",
              );

              showTodayEgoIntroSheet(this.context, egoInfoModel);
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
                          uid: "test",
                          messageHash: messages[index].messageHash!,
                        );

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
