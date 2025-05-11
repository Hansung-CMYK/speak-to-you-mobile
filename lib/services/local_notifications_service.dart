import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  // Private constructor for singleton pattern
  LocalNotificationsService._internal();

  //Singleton instance
  static final LocalNotificationsService _instance = LocalNotificationsService._internal();

  //Factory constructor to return singleton instance
  factory LocalNotificationsService.instance() => _instance;

  //Main plugin instance for handling notifications
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  //Android-specific initialization settings using app launcher icon
  final _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

  //iOS-specific initialization settings with permission requests
  final _iosInitializationSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  //Android notification channel configuration
  final _androidChannel = const AndroidNotificationChannel(
    'channel_id',
    'Channel name',
    description: 'Android push notification channel',
    importance: Importance.max,
  );

  //Flag to track initialization status
  bool _isFlutterLocalNotificationInitialized = false;

  //Counter for generating unique notification IDs
  int _notificationIdCounter = 0;

  /// Initializes the local notifications plugin for Android and iOS.
  Future<void> init() async {
    // Check if already initialized to prevent redundant setup
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    // Create plugin instance
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Combine platform-specific settings
    final initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
      iOS: _iosInitializationSettings,
    );

    // Initialize plugin with settings and callback for notification taps
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // Handle notification tap in foreground
          print('Foreground notification has been tapped: ${response.payload}');
        });

    // Create Android notification channel
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    // Mark initialization as complete
    _isFlutterLocalNotificationInitialized = true;
  }

  /// Show a local notification with the given title, body, and payload.
  Future<void> showNotification(
      String? title,
      String? body,
      String? payload,
      ) async {
    final styleInformation = BigTextStyleInformation(
      body ?? '',
      contentTitle: title ?? '제목 없음',
      summaryText: '🎉 오늘도 고생했어요 🎉',
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
    );

    final androidDetails = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: styleInformation,
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

    await _flutterLocalNotificationsPlugin.show(
      _notificationIdCounter++,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}