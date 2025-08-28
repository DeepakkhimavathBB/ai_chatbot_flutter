import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification and timezone settings
  static Future<void> init() async {
    // Initialize timezone data
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // change if needed

    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Combine platform settings
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Schedule a notification at a specific date and time
  static Future<void> scheduleAlarm(
      int id, String title, String body, DateTime dateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarm Notifications',
          channelDescription: 'Channel for Alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }
}
