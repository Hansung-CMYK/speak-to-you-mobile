import 'package:ego/screens/home_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: KeyboardVisibilityProvider(child: HomeChatTest())));
}
