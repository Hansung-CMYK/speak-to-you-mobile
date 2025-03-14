import 'package:flutter/services.dart';

import 'package:ego/widgets/customtoast/custom_toast.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareOneDiary(String text, CustomToast customToast) async {
  try {
    final ByteData bytes = await rootBundle.load('assets/image/first_diary_sample_image.png');
    final Uint8List uint8List = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/first_diary_sample_image.png');
    await tempFile.writeAsBytes(uint8List);

    final result = await Share.shareXFiles([XFile(tempFile.path)], text: text);

    if (result.status == ShareResultStatus.success) {
      customToast.showTopToast();
    }
  } catch (e) {
    print('에러 발생: $e');
  }
}
