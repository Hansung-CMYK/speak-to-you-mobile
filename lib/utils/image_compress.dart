import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// 갤러리에서 이미지 골라서 1MB 미만으로 압축
Future<File?> pickAndCompressImage() async {
  final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (picked == null) return null;

  // 임시 저장 디렉토리
  final dir = await getTemporaryDirectory();
  String targetPath =
      '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

  // 초기 퀄리티
  int quality = 90;
  File? compressed;

  // 점진적으로 퀄리티 낮추며 1 MB 미만 될 때까지 반복
  do {
    compressed =
        (await FlutterImageCompress.compressAndGetFile(
              picked.path,
              targetPath,
              quality: quality,
            ))
            as File?;
    quality -= 10;
  } while (compressed != null &&
      await compressed.length() > 700 * 1024 && // 700 KB 이하면 OK
      quality >
          20 // 품질 최소선
          );

  return compressed;
}
