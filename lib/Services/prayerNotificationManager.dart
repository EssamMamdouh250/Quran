import 'package:quran/Services/notificationService.dart';
import 'package:quran/UI/Screens/home/tabs/time/model/PrayerTimeModel.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayerNotificationManager {
  Future<void> schedulePrayer({
    required PrayTime prayer,
    required int id,
  }) async {
    // prayer.rawTime example: "16:35"
    final parts = prayer.rowTime.split(":");

    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
    );

    // If today's prayer time has already passed,
    // schedule it for tomorrow.
    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await Notificationservice.instance.scheduleNotification(
      id: id,
      title: prayer.name,
      body: "It's time for ${prayer.name}",
      scheduledDate: scheduledDate,
    );
    print("Scheduled ${prayer.name} at $scheduledDate");
  }

  Future<void> scheduleAllPrayers(List<PrayTime> prayers) async {
    for (int i = 0; i < prayers.length; i++) {
      if (prayers[i].alarm) {
        await schedulePrayer(prayer: prayers[i], id: i);
      }
    }
  }

  Future<void> cancelAll() async {
    await Notificationservice.instance.flutterLocalNotificationsPlugin
        .cancelAll();
  }
}
