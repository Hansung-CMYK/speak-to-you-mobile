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
import 'package:flutter/services.dart';
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
  static const _audioChannel = MethodChannel('app.channel.audio');
  final ScrollController _scrollController = ScrollController();
  late VoiceChatSocketClient socketClient;

  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isChatVisible = false;

  final double iconWidth = 35;
  final double iconHeight = 35;

  late List<ChatHistory> chatHistoryList;

  // 🔸 Chat 상태 저장 변수
  ChatHistory? _latestUserChat;
  StringBuffer _llmBuffer = StringBuffer();
  bool _isReceivingAudio = false;

  @override
  void initState() {
    super.initState();
    _initializeChatHistory();

    socketClient = VoiceChatSocketClient(
      userId: widget.uid,
      egoId: widget.egoModelV2.id!,
      speaker: "default",
      onMessage: _handleSocketMessage,
      onAudioChunk: _handleAudioChunk,
    );

    socketClient.connect();
  }

  void _initializeChatHistory() async {
    chatHistoryList = [];
  }

  @override
  void dispose() {
    socketClient.stop();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _setSystemMicMute(bool mute) async {
    try {
      await _audioChannel.invokeMethod('setMicMute', {'mute': mute});
    } on PlatformException catch (e) {
      print('🔈 시스템 마이크 음소거 오류: ${e.message}');
    }
  }

  Future<void> _setSystemSpeakerMute(bool mute) async {
    try {
      await _audioChannel.invokeMethod('setSpeakerMute', {'mute': mute});
    } on PlatformException catch (e) {
      print('🔇 시스템 스피커 음소거 오류: ${e.message}');
    }
  }

  void _addChat(ChatHistory chat) {
    setState(() {
      chatHistoryList.add(chat);
    });
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
        final text = message['text'] ?? '';
        print("🗣️ 실시간 텍스트: $text");

        setState(() {
          // 기존 채팅 제거
          if (_latestUserChat != null) {
            chatHistoryList.remove(_latestUserChat);
          }

          // 새 채팅 생성
          _latestUserChat = ChatHistory(
            uid: widget.uid,
            chatRoomId: 1,
            content: text,
            type: 'u',
            chatAt: DateTime.now(),
            isDeleted: false,
            contentType: "TEXT",
          );

          chatHistoryList.add(_latestUserChat!);
        });

        _scrollToBottom();
        break;

      case 'audio_chunk':
        _isReceivingAudio = true;

        final base64Str = message['audio_base64'];
        if (base64Str == null || base64Str.isEmpty) {
          print("⚠️ audio_base64 없음");
          return;
        }

        try {
          final bytes = base64Decode(base64Str);
          print("📥 [오디오 디코딩 완료] ${bytes.length} bytes");
          socketClient.onAudioChunk(bytes);
        } catch (e) {
          print("❌ audio_base64 디코딩 실패: $e");
        }
        break;

      case 'fullSentence':
        print("✅ STT 종료: ${message['text']}");
        _latestUserChat = null;
        break;

      case 'response_chunk':
        print("🤖 LLM 응답 중: ${message['text']}");
        _llmBuffer.write(message['text'] ?? '');
        break;

      case 'response_done':
        print("✅ 서버 응답 완료");

        final finalText = _llmBuffer.toString().trim();
        if (finalText.isNotEmpty) {
          _addChat(ChatHistory(
            uid: widget.uid,
            chatRoomId: 1,
            content: finalText,
            type: 'e',
            chatAt: DateTime.now(),
            isDeleted: false,
            contentType: "TEXT",
          ));
        }

        _llmBuffer.clear();
        _isReceivingAudio = false;
        break;

      case 'cancel_audio':
        print("🛑 오디오 재생 취소 요청");
        socketClient.stopAudio();
        break;

      default:
        print("⚠️ 처리되지 않은 타입: ${message['type']}");
    }
  }

  void _handleAudioChunk(Uint8List data) {
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
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    isMicOn ? 'assets/icon/mic_on.svg' : 'assets/icon/mic_off.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await _setSystemMicMute(isMicOn);

                    await socketClient.toggleMic();
                    setState(() {
                      isMicOn = !isMicOn;
                    });
                  },
                ),
                SizedBox(width: 25.w),
                IconButton(
                  icon: SvgPicture.asset(
                    isSpeakerOn ? 'assets/icon/sound_on.svg' : 'assets/icon/sound_off.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await _setSystemSpeakerMute(isSpeakerOn);

                    setState(() {
                      isSpeakerOn = !isSpeakerOn;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icon/chat_history.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatHistoryScreen(chatHistories: chatHistoryList),
                      ),
                    );
                  },
                ),
                SizedBox(width: 25.w),
                IconButton(
                  icon: SvgPicture.asset(
                    isChatVisible ? 'assets/icon/disappear_chat.svg' : 'assets/icon/appear_chat.svg',
                    width: iconWidth,
                    height: iconHeight,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 600.h,
                      child: Image.asset(
                        'assets/image/ego_body_image.png',
                        fit: BoxFit.contain,
                      ),
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
            scaffoldGeometry.floatingActionButtonSize.width) / 2;

    final double fabY =
        scaffoldGeometry.contentBottom -
            (scaffoldGeometry.floatingActionButtonSize.height / 2) +
            20;

    return Offset(fabX, fabY);
  }
}