import 'package:quran/UI/Screens/home/tabs/time/network/aladhan_Api.dart';
import 'package:quran/UI/Screens/home/tabs/time/model/PrayerTimeModel.dart';

class TimingRepe {
  final AladhanApi aladhanApi;

  TimingRepe({required this.aladhanApi});
  Future<TimingModel> getTimes(String city, String country) async {
    try {
      final times = await aladhanApi.getPrayerTimes(
        date: getCurrentDate(),
        city: city,
        country: country,
      );
      TimingModel prayerTime = TimingModel.fromJson(times.data);
      return prayerTime;
    } catch (e) {
      print("API ERROR: $e");
      rethrow;
    }
  }
}

String getCurrentDate() {
  final now = DateTime.now();

  final day = now.day.toString().padLeft(2, '0');
  final month = now.month.toString().padLeft(2, '0');
  final year = now.year;
  print("$day-$month-$year");
  return "$day-$month-$year";
}
