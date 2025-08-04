import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sales_master_app/services/toast_notification_service.dart';

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init(BuildContext context) async {
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      print(Theme.of(context).colorScheme.outlineVariant);
      if (notification != null) {
        ToastNotificationService.showInfo(
          context,
          notification.title ?? 'Notification',
          Theme.of(context).colorScheme.outlineVariant,
          notification.body ?? '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification clicked: ${message.messageId}');
    });
  }
}
