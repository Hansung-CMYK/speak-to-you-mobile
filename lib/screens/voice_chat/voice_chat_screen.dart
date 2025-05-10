import 'package:ego/models/ego_info_model.dart';
import 'package:ego/screens/voice_chat/top_call_time_banner.dart';
import 'package:ego/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoiceChatScreen extends StatefulWidget {
  final EgoInfoModel egoInfoModel;
  final String uid;

  const VoiceChatScreen({
    Key? key,
    required this.egoInfoModel,
    required this.uid,
  }) : super(key: key);

  @override
  _VoiceChatScreenState createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  bool isMicOn = true;
  bool isSpeakerOn = true;
  bool isChatVisible = false;

  final double iconWidth = 35;
  final double iconHeight = 35;

  @override
  Widget build(BuildContext context) {
    EgoInfoModel egoInfo = widget.egoInfoModel;
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
                  onPressed: () {
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
                    // 채팅 기록 열기 등
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
            child: TopCallTimeBanner(egoName: egoInfo.egoName),
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
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4), // 반투명 오버레이
                      child: Center(
                        child: Text(
                          '채팅 화면 (예시)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
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
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;

    final double fabY =
        scaffoldGeometry.contentBottom -
        (scaffoldGeometry.floatingActionButtonSize.height / 2) +
        20;

    return Offset(fabX, fabY);
  }
}
