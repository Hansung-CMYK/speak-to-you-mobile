import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/models/persona_ego_model.dart';
import 'package:ego/services/setting_service.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/types/dialog_type.dart';
import 'package:ego/widgets/alert_dialog.dart';
import 'package:ego/widgets/chat/ego_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/io.dart';
import 'package:path/path.dart' as p;

import 'package:ego/services/ego/ego_service.dart';


const int kStreamSampleRate = 16000; // 16 kHz
const int kFlushBytes = 3200; // 0.1 s @16 kHz (PCM16 mono)

class PronunciationWs {
  final Uri uri = Uri.parse('${SettingsService().webVoiceUrl}/pronunciation-test');
  late IOWebSocketChannel _ch;
  bool _opened = false;
  bool get isOpened => _opened;

  Future<void> start(String script, void Function(dynamic) onEvent) async {
    if (_opened) return;
    _ch = IOWebSocketChannel.connect(uri);
    _opened = true;
    _ch.stream.listen(
      onEvent,
      onDone: () => _opened = false,
      onError: (_) => _opened = false,
    );
    _ch.sink.add(jsonEncode({'script': script}));
  }

  void sendPcm(Uint8List pcmBytes) {
    if (!_opened) return;
    final meta = utf8.encode(jsonEncode({'sampleRate': kStreamSampleRate}));
    final header = ByteData(4)..setUint32(0, meta.length, Endian.little);
    _ch.sink.add(
      (BytesBuilder()
            ..add(header.buffer.asUint8List())
            ..add(meta)
            ..add(pcmBytes))
          .takeBytes(),
    );
  }

  void sendEos() {
    if (!_opened) return;
    _ch.sink.add(jsonEncode({'eos': true}));
  }

  void close() {
    if (!_opened) return;
    _ch.sink.close();
    _opened = false;
  }
}

class UserInfoOnboardingScreen extends StatefulWidget {
  const UserInfoOnboardingScreen({Key? key, required this.onOnboardingComplete, required this.egoModelV2})
    : super(key: key);
  final VoidCallback onOnboardingComplete;
  final EgoModelV2 egoModelV2;
  @override
  State<UserInfoOnboardingScreen> createState() =>
      _UserInfoOnboardingScreenState();
}

class _UserInfoOnboardingScreenState extends State<UserInfoOnboardingScreen> {
  late final FlutterSoundRecorder _fsRecorder;
  late final FlutterSoundPlayer _fsPlayer;
  late final PronunciationWs _ws;

  final StreamController<Uint8List> _pcmStream = StreamController.broadcast();
  final List<Uint8List> _buf = [];
  int _bufBytes = 0;

  bool _waiting = false;
  bool _isRecording = false;
  int _recSec = 0;
  Timer? _timer;
  String? _localWav;

  final List<String> _questions = [
    '1) 가장 좋아하는 음식은 무엇인가요?',
    '2) 평소 즐겨 하는 취미나 여가 활동은 무엇인가요?',
    '3) 하루 중 가장 행복하다고 느끼는 순간이 언제인가요?',
    '4) 최근에 본 영화나 드라마 중 가장 인상 깊었던 장면은?',
    '5) 스트레스를 받을 때 듣는 노래가 있나요? 있다면 어떤 곡인가요?',
    '6) 친구들과의 모임에서 주로 맡는 역할은 무엇인가요?',
    '7) 최근에 구매한 물건 중 가장 만족스러웠던 것은?',
    '8) 집에서 가장 오래 머무르는 공간은 어디인가요?',
    '9) 외출할 때 빠뜨리지 않는 필수 아이템은 무엇인가요?',
    '10) 좋아하는 계절과 그 이유는 무엇인가요?',
  ];

  final List<String> _examples = [
    '달콤한 디저트를 좋아해서 브라우니나 마카롱을 자주 먹어요.',
    '요가를 하거나 퍼즐 맞추기를 즐겨 해요.',
    '따뜻한 차 한 잔 마실 때가 가장 행복해요.',
    '“기생충”에서 가족이 다 함께 식탁에 모이는 장면이 인상 깊었어요.',
    '스트레스를 받을 땐 잔잔한 재즈 플레이리스트를 듣습니다.',
    '모임에서 분위기 메이커 역할을 맡아요.',
    '최근에 산 블루투스 스피커가 음질이 좋아서 만족스러웠어요.',
    '거실 소파에서 책 읽는 시간을 가장 오래 보내요.',
    '밖에 나갈 때는 반드시 보조 배터리를 챙겨요.',
    '가을을 좋아해요. 선선한 날씨와 단풍이 아름다워서요.',
  ];

  int _idx = 0;
  String _script = '2025년 캡스톤디자인 에고 시연입니다';

  final List<ChatHistory> _msg = [];
  final ScrollController _scroll = ScrollController();
  final TextEditingController _txtCtl = TextEditingController();
  final FocusNode _focus = FocusNode();
  late BuildContext _rootContext;

  @override
  void initState() {
    super.initState();
    _ws = PronunciationWs();
    _fsRecorder = FlutterSoundRecorder();
    _fsPlayer = FlutterSoundPlayer();
    _initAudio();
    _pcmStream.stream.listen(_onPcmData);
    _addSystem(_questions[_idx]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rootContext = context;
    });
    // WebSocket 연결 미리 하지 않음
  }

  Future<void> _initAudio() async {
    await Permission.microphone.request();
    await _fsRecorder.openRecorder();
    await _fsRecorder.setSubscriptionDuration(const Duration(milliseconds: 50));
    await _fsPlayer.openPlayer();
  }

  void _onPcmData(Uint8List chunk) {
    if (!_waiting) return;
    _buf.add(chunk);
    _bufBytes += chunk.length;
    if (_bufBytes >= kFlushBytes) {
      final merged = BytesBuilder();
      int need = kFlushBytes;
      final remain = <Uint8List>[];
      for (final c in _buf) {
        if (need <= 0) {
          remain.add(c);
        } else if (c.length <= need) {
          merged.add(c);
          need -= c.length;
        } else {
          merged.add(c.sublist(0, need));
          remain.add(c.sublist(need));
          need = 0;
        }
      }
      _ws.sendPcm(merged.takeBytes());
      _buf
        ..clear()
        ..addAll(remain);
      _bufBytes -= kFlushBytes;
    }
  }

  Future<void> _startRec() async {
    if (_isRecording) return;
    // 마지막 답변(STT) 단계에서만 WS 연결
    if (!_ws.isOpened) {
      _ws.start(_script, _onWsEvent);
    }
    _waiting = true;
    final dir = await getTemporaryDirectory();
    _localWav = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.wav';
    await _fsRecorder.startRecorder(
      toStream: _pcmStream.sink,
      codec: Codec.pcm16,
      sampleRate: kStreamSampleRate,
      numChannels: 1,
    );
    setState(() {
      _isRecording = true;
      _recSec = 0;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => mounted ? setState(() => _recSec++) : null,
    );
    _addUser('음성 입력 시작', 'AUDIO');
  }

  Future<void> _stopRec() async {
    if (!_isRecording) return;
    _timer?.cancel();
    await _fsRecorder.stopRecorder();
    if (_bufBytes > 0) {
      final all = BytesBuilder();
      for (final c in _buf) all.add(c);
      _ws.sendPcm(all.takeBytes());
      _buf.clear();
      _bufBytes = 0;
    }
    setState(() => _isRecording = false);
    _addUser('음성 입력 완료 ($_recSec s)', 'AUDIO');

    final silence = Uint8List(kFlushBytes);
    for (int i = 0; i < 5; i++) {
      _ws.sendPcm(silence);
    }
    Timer(const Duration(seconds: 3), () {
      if (!_isRecording && _ws.isOpened) {
        for (int i = 0; i < 5; i++) {
          _ws.sendPcm(silence);
        }
      }
    });
    if (_localWav != null && File(_localWav!).existsSync()) {
      await _fsPlayer.startPlayer(fromURI: _localWav, codec: Codec.pcm16WAV);
    }
  }

  String refer_path = '/home/keem/refer';
  void _onWsEvent(dynamic e) {
    final d = jsonDecode(e as String);
    switch (d['type']) {
      case 'fullSentence':
        _addSystem('🔊 "${d['text']}"');
        break;
      case 'result':
        final acc = (d['accuracy'] * 100).round();
        if (d['verdict'] == 'OK') {
          _addSystem('✅ 발음 $acc% 일치! 저장되었습니다.');
          widget.onOnboardingComplete();
          _waiting = false;
        } else {
          _addSystem('⚠️ 발음 $acc% 일치 — 다시 시도해주세요');
        }
        break;
      case 'saved':
        refer_path += d['path'];
        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted) return;
          showAlertDialog(
            context: context,
            dialogType: DialogType.success,
            title: '에고 설정이 완료되었습니다!',
            content: '모든 설정이 완료되었어요.\n확인을 누르면 다음 화면으로 이동합니다.',
            buttonText: '확인',
            buttonBackgroundColor: AppColors.primary,
            buttonForegroundColor: AppColors.white,
          ).then((_) async {
            /// TODO 에고 정보 저장 (경로) 끝나면 메인 화면으로 넘어가기
            widget.egoModelV2.voiceUrl = refer_path;
            final createdEgo = await EgoService.createNewEgo(widget.egoModelV2);

            final qNa = [_questions, _examples];

            final personaEgoModel = PersonaEgoModel(
                mbti: createdEgo.mbti,
                name:createdEgo.name ,
                egoId:createdEgo.id! ,
                interview: qNa
            );

            PersonaEgoModel.sendPersonaEgoModel(personaEgoModel);

            if (!mounted) return;

            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(_rootContext, 'Main'); // Main화면으로 이동
          });
        });
        break;
      case 'error':
        _addSystem('❌ 오류: ${d['message']}');
        break;
    }
  }

  Future<void> _onPlayExample() async {
    _addUser(_examples[_idx], 'TEXT');
    if (_idx < _questions.length - 1) {
      setState(() => _idx++);
      _addSystem(_questions[_idx]);
    } else {
      // 마지막 예시 후 STT 단계 진입
      // _waiting = true;
      if (!_ws.isOpened) {
        _ws.start(_script, _onWsEvent);
      }
      _addSystem('다음 문장을 읽어주세요:\n"$_script"');
      // _startRec();
    }
  }

  void _sendTxt() {
    final txt = _txtCtl.text.trim();
    if (txt.isEmpty) return;
    _txtCtl.clear();
    // 사용자가 직접 답변한 경우
    _addUser(txt, 'TEXT');
    if (_idx < _questions.length - 1) {
      setState(() => _idx++);
      _addSystem(_questions[_idx]);
    } else {
      // 마지막 질문에 직접 답변 후 STT
      // _waiting = true;
      if (!_ws.isOpened) {
        _ws.start(_script, _onWsEvent);
      }
      _addSystem('다음 문장을 읽어주세요:\n"$_script"');
      // _startRec();
    }
  }

  void _addSystem(String txt) {
    setState(() {
      _msg.add(
        ChatHistory(
          uid: 'system',
          chatRoomId: 0,
          content: txt,
          type: 's',
          chatAt: DateTime.now(),
          isDeleted: false,
          contentType: 'TEXT',
        ),
      );
    });
    _scrollBottom();
  }

  void _addUser(String txt, String contentType) {
    setState(() {
      _msg.add(
        ChatHistory(
          uid: 'user',
          chatRoomId: 0,
          content: txt,
          type: 'u',
          chatAt: DateTime.now(),
          isDeleted: false,
          contentType: contentType,
          messageHash: ChatHistory.generateSHA256(
            'user|${DateTime.now()}|$contentType|$txt',
          ),
        ),
      );
    });
    _scrollBottom();
  }

  void _scrollBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pcmStream.close();
    _fsRecorder.closeRecorder();
    _fsPlayer.closePlayer();
    _ws.close();
    _txtCtl.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray200,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.white,
        toolbarHeight: kToolbarHeight + 12.h,
        title: Text(
          '회원 정보 입력',
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: _onPlayExample,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RawScrollbar(
              controller: _scroll,
              thumbVisibility: true,
              thickness: 3,
              thumbColor: AppColors.gray700,
              radius: Radius.circular(10.r),
              child: ListView.builder(
                controller: _scroll,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: _msg.length,
                itemBuilder:
                    (_, i) => ChatBubble(
                      message: _msg[i],
                      previousMessage: i < _msg.length - 1 ? _msg[i + 1] : null,
                      nextMessage: i > 0 ? _msg[i - 1] : null,
                      onDelete: () {},
                    ),
              ),
            ),
          ),
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(child: _isRecording ? _wave() : _txt()),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: _isRecording ? null : _sendTxt,
                      onLongPressStart: (_) => _startRec(),
                      onLongPressEnd: (_) => _stopRec(),
                      child: CircleAvatar(
                        backgroundColor:
                            _isRecording ? Colors.red : AppColors.accent,
                        radius: 24.r,
                        child: SvgPicture.asset(
                          _isRecording
                              ? 'assets/icon/stop.svg'
                              : 'assets/icon/paper_plane.svg',
                          width: 24.w,
                          height: 24.h,
                        ),
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

  Widget _txt() => TextField(
    controller: _txtCtl,
    focusNode: _focus,
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: '답변을 입력하세요',
    ),
    onSubmitted: (_) => _sendTxt(),
  );

  Widget _wave() => Container(
    height: 50.h,
    decoration: BoxDecoration(
      color: const Color(0x33FF0000),
      borderRadius: BorderRadius.circular(25.r),
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        '$_recSec s',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
