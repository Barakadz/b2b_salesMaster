import 'package:data_layer/data_layer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    print('FCM Token: $token');

    if (token != null) {
      saveFirebaseToken(token);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("FCM Token refreshed: $newToken");
      saveFirebaseToken(newToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // Must match channel ID below
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              importance: Importance.max,
              priority: Priority.max,
              icon: "@mipmap/ic_launcher",
              styleInformation: BigTextStyleInformation(
                notification.body ?? '',
              ),
            ),
          ),
        );
      }
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification clicked: ${message.messageId}');
    });
  }

  static Future<void> unsubscribeFromTopic({required String topicName}) async {
    await _messaging.unsubscribeFromTopic(topicName);
  }

  static Future<void> saveFirebaseToken(String token) async {
    try {
      await Api.getInstance()
          .post("save-fcm-token", data: {"fcm_token": token});
    } catch (e) {
      print("Failed to save token: $e");
    }
  }

  static Future<void> removeFirebaseToken() async {
    try {
      await Api.getInstance().post("delete-fcm-token");
    } catch (e) {
      print("Failed to delete token: $e");
    }
  }

  // no need to check if user already subscribed , firebase will ignore the request in that case
  static Future<void> subscribeToTopic({required String topicName}) async {
    await _messaging.subscribeToTopic(topicName);
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  ); // Or your custom icon

  const InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

Future<void> setupNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for foreground push notifications.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();
  await plugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
