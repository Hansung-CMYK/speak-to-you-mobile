import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:share_plus/share_plus.dart';

/// 전체 일기를 공유하는 함수 입니다.
///
Future<void> shareAllDiary(String text, CustomToast customToast) async {
  final result = await Share.share(text);

  if (result.status == ShareResultStatus.success) {
    customToast.showTopToast();
  }
}
