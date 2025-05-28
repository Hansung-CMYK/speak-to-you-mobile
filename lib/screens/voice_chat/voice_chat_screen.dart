import 'dart:convert';
import 'dart:typed_data';

import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/models/ego_info_model.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/screens/voice_chat/call_time_banner.dart';
import 'package:ego/screens/voice_chat/voice_chat_overlay.dart';
import 'package:ego/services/chat/voice/voice_chat_socket.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat_history_screen.dart';

class VoiceChatScreen extends StatefulWidget {
  final EgoModelV2 egoModelV2;
  final String uid;

  const VoiceChatScreen({
    Key? key,
    required this.egoModelV2,
    required this.uid,
  }) : super(key: key);

  @override
  _VoiceChatScreenState createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late VoiceChatSocketClient socketClient;

  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isChatVisible = false;

  final double iconWidth = 35;
  final double iconHeight = 35;

  late List<ChatHistory> chatHistoryList;

  @override
  void initState() {
    super.initState();
    _initializeChatHistory();

    socketClient = VoiceChatSocketClient(
      userId: widget.uid,
      egoId: widget.egoModelV2.id!,
      speaker: "karina", // 필요에 따라 변경 가능
      onMessage: _handleSocketMessage,
      onAudioChunk: _handleAudioChunk,
    );

    socketClient.connect();
  }

  void _initializeChatHistory() async
  {
    // 임시 데이터
    chatHistoryList = [];
  }

  @override
  void dispose() {
    socketClient.stop();
    _scrollController.dispose();
    super.dispose();
  }

  void _addChat(ChatHistory chat) {
    setState(() {
      chatHistoryList.add(chat);
    });
    // 채팅이 추가된 후에 스크롤을 마지막으로 이동
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _handleSocketMessage(Map<String, dynamic> message) {
    switch (message['type']) {
      case 'realtime':
        print("🗣️ 실시간 텍스트: ${message['text']}");
        _addChat(ChatHistory(
          uid: widget.uid,
          chatRoomId: 1,
          content: message['text'] ?? '',
          type: 'u',
          chatAt: DateTime.now(),
          isDeleted: false,
          contentType: "TEXT"
        ));
        break;

      case 'fullSentence':
        print("✅ STT 종료: ${message['text']}");
        break;

      case 'response_chunk':
        print("🤖 LLM 응답 중: ${message['text']}");
        break;

      case 'response_done':
        print("✅ 서버 응답 완료");
        _addChat(ChatHistory(
            uid: "애고",
            chatRoomId: 1,
            content: message['text'] ?? '',
            type: 'e',
            chatAt: DateTime.now(),
            isDeleted: false,
            contentType: "TEXT"
        ));
        break;

      case 'cancel_audio':
        print("🛑 오디오 재생 취소 요청");
        // 오디오만 중단
        socketClient.stopAudio(); // 또는 socketClient.stopAudio() 를 새로 만들어도 OK
        break;

      case 'audio_chunk':
        final base64Str = message['audio_base64'];
        if (base64Str == null || base64Str.isEmpty) {
          print("⚠️ audio_base64 없음");
          return;
        }

        try {
          final bytes = base64Decode(base64Str);
          print("📥 [오디오 디코딩 완료] ${bytes.length} bytes");

          // 오디오 디코딩 결과를 재생하도록 전달
          socketClient.onAudioChunk(bytes); // 내부에서 재생 처리
        } catch (e) {
          print("❌ audio_base64 디코딩 실패: $e");
        }
        break;

      default:
        print("⚠️ 처리되지 않은 타입: ${message['type']}");
    }
  }

  void _handleAudioChunk(Uint8List data) {
    // TODO: 오디오 플레이어 추가 처리 가능
    print("🔊 오디오 청크 수신 (${data.length} bytes)");
  }

  @override
  Widget build(BuildContext context) {
    EgoModelV2 egoInfo = widget.egoModelV2;
    String uid = widget.uid;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppColors.darkCharcoal,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 좌측 Icons
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    isMicOn
                        ? 'assets/icon/mic_on.svg'
                        : 'assets/icon/mic_off.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await socketClient.toggleMic();
                    setState(() {
                      isMicOn = !isMicOn;
                    });
                  },
                ),
                SizedBox(width: 25.w),
                IconButton(
                  icon: SvgPicture.asset(
                    isSpeakerOn
                        ? 'assets/icon/sound_on.svg'
                        : 'assets/icon/sound_off.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isSpeakerOn = !isSpeakerOn;
                    });
                  },
                ),
              ],
            ),

            // 우측 Icons
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icon/chat_history.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatHistoryScreen(
                          chatHistories: chatHistoryList,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 25.w),
                IconButton(
                  icon: SvgPicture.asset(
                    isChatVisible
                        ? 'assets/icon/disappear_chat.svg'
                        : 'assets/icon/appear_chat.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isChatVisible = !isChatVisible;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: const _LowerCenterDockedFabLocation(),
      floatingActionButton: CallEndButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: TopCallTimeBanner(egoName: egoInfo.name),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Image.asset(
                      'assets/image/ego_1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isChatVisible)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VoiceChatOverlay(
                      chatHistories: chatHistoryList,
                      height: 300.h,
                      scrollController: _scrollController,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/**
 * 실시간 대화 종료 버튼
 * */
class CallEndButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CallEndButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65.w,
      height: 65.h,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.call_end, size: 36.0, color: AppColors.white),
      ),
    );
  }
}

class _LowerCenterDockedFabLocation extends FloatingActionButtonLocation {
  const _LowerCenterDockedFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;

    final double fabY =
        scaffoldGeometry.contentBottom -
        (scaffoldGeometry.floatingActionButtonSize.height / 2) +
        20;

    return Offset(fabX, fabY);
  }
}
