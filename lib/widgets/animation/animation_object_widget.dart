import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class AnimationObjectWidget extends StatelessWidget {
  final String animationName;
  final bool cameraControls;
  final bool autoRotate;
  final bool autoPlay;

  const AnimationObjectWidget({
    super.key,
    required this.animationName,
    this.cameraControls = true,
    required this.autoRotate,
    required this.autoPlay,
  });

  @override
  Widget build(BuildContext context) {
    return O3D(
      src: 'assets/Ego_model.glb',
      ar: false,
      autoPlay: autoPlay,
      autoRotate: autoRotate,
      autoRotateDelay: 0,
      animationName: 'HI',
      cameraControls: cameraControls,
      cameraOrbit: CameraOrbit(0, 90, 2.0),
    );
  }
}
