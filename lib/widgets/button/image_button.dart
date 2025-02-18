import 'package:flutter/material.dart';

/// 이미지를 추가할 수 있는 버튼이다.
///
/// [imagePath] 이미지 asset이 저장된 경로 <br>
/// [onTab] 버튼 클릭 시 동작 <br>
/// [width] 이미지의 너비 (Default: 기본 이미지) <br>
/// [height] 이미지의 높이 (Default: 기본 이미지) <br>
/// [radius] 이미지의 모서리 Border 값 (Default: 기본 이미지) <br>
class ImageButton extends StatelessWidget {
  final String imagePath;
  final Function onTab;
  final double? width;
  final double? height;
  final double radius;

  const ImageButton({
    super.key,
    required this.imagePath,
    required this.onTab,
    this.width,
    this.height,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // 실제 이미지를 버튼으로 만드는 클래스
      borderRadius: BorderRadius.circular(radius), // 모서리 값 설정
      onTap: () {
        // 클릭 시 동작
        onTab();
      },
      child: Image.asset(
        // 이미지 소스 조정
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}
