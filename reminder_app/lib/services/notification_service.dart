import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
  }

  static Future show(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'reminder',
        importance: Importance.max,
      ),
    );

    await _plugin.show(0, title, body, details);
  }
}