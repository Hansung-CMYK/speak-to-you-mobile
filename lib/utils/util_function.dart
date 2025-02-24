import 'package:intl/intl.dart';

class UtilFunction {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat("yyyy년 MM월 dd일").format(dateTime);
  }
}