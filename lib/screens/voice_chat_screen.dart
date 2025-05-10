import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  final String uid;
  final int egoId;

  const CallScreen({
    Key? key,
    required this.uid,
    required this.egoId,
  }) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isMicOn = true;
  bool isSpeakerOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isMicOn ? Icons.mic : Icons.mic_off,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isMicOn = !isMicOn;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: const _LowerCenterDockedFabLocation(),
      floatingActionButton: SizedBox(
        width: 72.0,
        height: 72.0,
        child: FloatingActionButton(
          onPressed: () {
            print('uid: ${widget.uid}, egoId: ${widget.egoId}');
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.call_end,
            size: 36.0,
          ),
        ),
      ),
    );
  }
}

class _LowerCenterDockedFabLocation extends FloatingActionButtonLocation {
  const _LowerCenterDockedFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width
        - scaffoldGeometry.floatingActionButtonSize.width) /
        2;

    // BottomAppBar 상단에서 FAB 중심까지 Y 위치 계산 (기본보다 조금 더 아래로 조정: +8)
    final double fabY = scaffoldGeometry.contentBottom -
        (scaffoldGeometry.floatingActionButtonSize.height / 2) +
        20;

    return Offset(fabX, fabY);
  }
}

