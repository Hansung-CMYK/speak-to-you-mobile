// 하나의 일기 이미지 생성을 요청합니다.
import 'package:ego/services/diary/image_create_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final diaryImageProvider = FutureProvider.family
    .autoDispose<String, ({String prompt})>((ref, param) async {
  return await ImageCreateService.sendGenImageRequest(
      prompt: param.prompt
  );
});