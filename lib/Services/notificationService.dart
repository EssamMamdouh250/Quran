import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

const channelId = "prayer_channel";
const channelName = "Prayer Notifications";

class Notificationservice {
  Notificationservice._();

  static final Notificationservice instance = Notificationservice._();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool isInit = false;

  // initial step

  Future<void> notiInitSetting() async {
    if (isInit) return;

    const fluttersettingAnd = AndroidInitializationSettings("ic_notification");
    const fluttersettingIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSetting = InitializationSettings(
      android: fluttersettingAnd,
      iOS: fluttersettingIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(settings: initSetting);
    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();

    isInit = true;
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: "Prayer reminder notifications",
        importance: Importance.high,
        priority: Priority.high,

        sound: RawResourceAndroidNotificationSound("azan20"),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "prayer",
    );
  }
}
