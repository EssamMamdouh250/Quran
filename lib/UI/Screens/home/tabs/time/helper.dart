import 'package:quran/UI/Screens/home/tabs/time/model/PrayerTimeModel.dart';

Map<String, dynamic> getNextPrayer(List<PrayTime> prayers) {
  final now = DateTime.now();
  for (int i = 0; i < prayers.length; i++) {
    final prayer = prayers[i];
    final time = prayer.rowTime.split(":");

    final prayerTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(time[0]),
      int.parse(time[1]),
    );

    if (prayerTime.isAfter(now)) {
      return {
        "name": prayer.name,
        "remaining": prayerTime.difference(now),
        "index": i,
      };
    }
  }
  return {"name": prayers[0].name, "remaining": Duration.zero, "index": 0};
}
