import 'dart:async';
import 'dart:ui';

import 'package:ego/screens/in_app_message.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../models/ego_info_model.dart';
import 'package:flutter/material.dart';

class LocalNotificationsService {
  LocalNotificationsService._internal();

  static final LocalNotificationsService _instance =
      LocalNotificationsService._internal();

  factory LocalNotificationsService.instance() => _instance;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final _androidInitializationSettings = const AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  final _iosInitializationSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final _androidChannel = const AndroidNotificationChannel(
    'channel_id',
    'Channel name',
    description: 'Android push notification channel',
    importance: Importance.max,
  );

  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> init() async {
    if (_isFlutterLocalNotificationInitialized) return;

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
      iOS: _iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Foreground notification tapped: ${response.payload}');
      },
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);

    _isFlutterLocalNotificationInitialized = true;

    checkTimeAndShowInAppMsg();
  }

  DateTime? _lastMessageShownDate;

  // 정해진 시간에 in app msg + push알림을 띄움
  void checkTimeAndShowInAppMsg() {
    const targetHour = 21;
    const targetMinute = 36;

    Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();

      print('${now.hour}, ${now.minute}');

      if (now.hour == targetHour && now.minute == targetMinute) {
        // 중복 방지를 위해 하루에 한 번만 띄우도록 시간 기록
        final lastShown = _lastMessageShownDate;
        final today = DateTime(now.year, now.month, now.day);

        if (lastShown == null || lastShown.isBefore(today)) {
          _lastMessageShownDate = today;

          // In-App 메시지 표시
          showNotification();
          print('✅ 매일 지정된 시간에 InApp 메시지 표시 완료');

          final androidDetails = AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            color: const Color(0xFF0066CC), // 푸른 계열 색상
            colorized: true, // 배경 색상 반영
            enableVibration: true,
            playSound: true,
            largeIcon: const DrawableResourceAndroidBitmap('diary_icon'),
            icon: '@mipmap/ic_launcher',
            visibility: NotificationVisibility.public,
          );

          const iosDetails = DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          );

          final notificationDetails = NotificationDetails(
            android: androidDetails,
            iOS: iosDetails,
          );

          _flutterLocalNotificationsPlugin.show(
            123,
            '일기 완성!',
            '🎉 오늘도 고생했어요 🎉',
            notificationDetails,
          );
        }
      }
    });
  }

  // 매일 정해진 시각에 push알림 생성 - 미동작
  showNotificationDaily({
    required int hour,
    required int min,
    required int sec,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0, //알림 id
      '알림 제목',
      '알림 내용',
      makeDate(hour, min, sec),
      NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName'),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  makeDate(h, m, s) {
    var now = tz.TZDateTime.now(tz.local);
    var when = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m, s);
    if (when.isBefore(now)) {
      return when.add(Duration(days: 1));
    } else {
      return when;
    }
  }

  // custom in app msg 호출
  Future<void> showNotification() async {

    // notification API가 완성되면 알림 저장 진행

    // FCM Custom in App Alert
    showFlushBarFromForegroundLocal();
  }
}