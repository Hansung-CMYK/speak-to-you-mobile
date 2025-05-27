import 'dart:convert';
import 'dart:io';

import 'package:ego/models/chat/chat_history_kafka_model.dart';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/providers/ego_provider.dart';
import 'package:ego/services/chat/chat_history_service.dart';
import 'package:ego/services/websocket/chat_kafka_socket_service.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/bottomsheet/today_ego_introV2.dart';
import 'package:ego/widgets/chat/ego_chat_bubble.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/egoicon/ego_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

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

  List<ChatHistory> messages = [];
  int _pageNum = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();

    fToast = FToast()..init(context);
    _fetchInitialData();

    _focusNode = FocusNode();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 200 && !_isLoading && _hasMore) {
        _fetchMoreData();
      }
    });

    // WebSocket 수신 훅
    _socketService.onMessageReceived((msg) {
      setState(() {
        messages.insert(0, ChatHistoryKafka.convertToChatHistory(msg));
      });
    });

    _socketService.connect(uid: widget.uid);
  }

  Future<void> _fetchInitialData() async {
    setState(() => _isLoading = true);
    final list = await ChatHistoryService.fetchChatHistoryList(
      uid: widget.uid,
      pageNum: _pageNum,
      pageSize: 15,
      chatRoomId: widget.chatRoomId,
    );
    if (list.isEmpty) {
      _hasMore = false;
    } else {
      messages.addAll(list);
      _pageNum++;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _fetchMoreData() async {
    setState(() => _isLoading = true);
    final list = await ChatHistoryService.fetchChatHistoryList(
      uid: widget.uid,
      pageNum: _pageNum,
      pageSize: 15,
      chatRoomId: widget.chatRoomId,
    );
    if (list.isEmpty) {
      _hasMore = false;
    } else {
      messages.addAll(list);
      _pageNum++;
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

  /* -------------------- 메시지 전송 -------------------- */

  void _sendText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final hashInput = "${widget.uid}|$formatted|TEXT|$text";
    final hash = ChatHistory.generateSHA256(hashInput);

    final msg = ChatHistory(
      uid: widget.uid,
      chatRoomId: widget.chatRoomId,
      content: text,
      type: "u",
      chatAt: now,
      isDeleted: false,
      messageHash: hash,
      contentType: 'TEXT',
    );

    _socketService.sendMessage(
      ChatHistory.convertToKafka(
        msg,
        to: widget.egoModel.id.toString(),
        contentType: 'TEXT',
      ),
    );

    setState(() {
      messages.insert(0, msg);
      _controller.clear();
    });
    _scrollToBottom();
  }

  Future<File?> _pickAndCompressImage() async {
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (picked == null) return null;

    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    int quality = 90;
    XFile? compressed;
    do {
      compressed = await FlutterImageCompress.compressAndGetFile(
        picked.path,
        targetPath,
        minWidth: 800,
        minHeight: 800,
        quality: quality,
      );
      quality -= 10;
    } while (compressed != null &&
        await compressed.length() > 700 * 1024 &&
        quality > 20);

    return compressed != null ? File(compressed.path) : null;
  }

  void _sendImage() async {
    final file = await _pickAndCompressImage();
    if (file == null) return;

    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final bytes = await file.readAsBytes();
    final b64 = base64Encode(bytes);
    final hashInput = "${widget.uid}|$formatted|IMAGE|$b64";
    final hash = ChatHistory.generateSHA256(hashInput);

    final msg = ChatHistory(
      uid: widget.uid,
      chatRoomId: widget.chatRoomId,
      content: b64,
      type: "u",
      chatAt: now,
      isDeleted: false,
      messageHash: hash,
      contentType: 'IMAGE',
    );

    _socketService.sendMessage(
      ChatHistory.convertToKafka(
        msg,
        to: widget.egoModel.id.toString(),
        contentType: 'IMAGE',
      ),
    );

    setState(() => messages.insert(0, msg));
    _scrollToBottom();
  }

  /* -------------------- UI helpers -------------------- */

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _timeText(String text) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
  );

  /* -------------------- Build -------------------- */

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.gray200,
        appBar: AppBar(
          title: Text(
            widget.egoModel.name,
            style: TextStyle(
              color: AppColors.gray900,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          surfaceTintColor: AppColors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: buildEgoListItem(widget.egoModel.profileImage, () {
                final async = ref.watch(
                  fullEgoInfoByEgoIdProvider(widget.egoModel.id!),
                );
                async.when(
                  data:
                      (ego) => showTodayEgoIntroSheetV2(
                        context,
                        ego,
                        isOtherEgo: true,
                        egoChatPossible: false,
                      ),
                  error: (_, __) => ref.invalidate(egoByIdProviderV2),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                );
              }, radius: 17),
            ),
          ],
        ),
        body: Column(
          children: [
            /* ---------- 메시지 리스트 ---------- */
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
                  itemBuilder: (_, i) {
                    final prev =
                        i < messages.length - 1 ? messages[i + 1] : null;
                    final next = i > 0 ? messages[i - 1] : null;
                    return ChatBubble(
                      message: messages[i],
                      previousMessage: prev,
                      nextMessage: next,
                      onDelete: () async {
                        try {
                          await ChatHistoryService.deleteChatMessage(
                            uid: widget.uid,
                            messageHash: messages[i].messageHash!,
                          );
                          setState(() => messages.removeRange(0, i + 1));
                          _focusNode.unfocus();
                        } catch (_) {
                          customToast.init(fToast);
                          customToast.showTopToast();
                        }
                      },
                    );
                  },
                ),
              ),
            ),

            /* ---------- 입력 영역 ---------- */
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.gray200, width: 2.w),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  child: Row(
                    children: [
                      /* 이미지 선택 버튼 */
                      IconButton(
                        icon: const Icon(
                          Icons.photo_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: _sendImage,
                      ),
                      /* 텍스트 입력 */
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '메시지를 입력하세요',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      /* 전송 버튼 */
                      CircleAvatar(
                        backgroundColor: AppColors.accent,
                        child: IconButton(
                          icon: SvgPicture.asset('assets/icon/paper_plane.svg'),
                          onPressed: _sendText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
