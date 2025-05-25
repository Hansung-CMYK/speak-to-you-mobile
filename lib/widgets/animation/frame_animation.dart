class FrameAnimation {
  String name;
  String key;// 해당 값이 glb파일에 있는 애니메이션 값과 같아야합니다.
  bool isChosen;

  FrameAnimation({required this.name, required this.key, required this.isChosen});
}

// 임시 값들
List<FrameAnimation> FrameAnimationsData = [
  FrameAnimation(name: 'SAY-HI', key: 'SAY-HI', isChosen: false),
  FrameAnimation(name: 'IDK', key: 'IDK', isChosen: false),
  FrameAnimation(name: 'SURPRISED', key: 'SURPRISED', isChosen: false),
  FrameAnimation(name: 'THINKING', key: 'THINKING', isChosen: false),
];