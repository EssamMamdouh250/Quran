class TimingModel {
  final String date;
  final String weekday;
  final String hijriDate;
  final String day;

  final List<PrayTime> prayTime;

  TimingModel({
    required this.day,
    required this.date,
    required this.weekday,
    required this.hijriDate,
    required this.prayTime,
  });

  factory TimingModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return TimingModel(
      day: data["date"]["gregorian"]["weekday"]["en"],
      date: data["date"]["readable"],
      weekday: data["date"]["gregorian"]["weekday"]["en"],
      hijriDate:
          "${data["date"]["hijri"]["day"]} ${data["date"]["hijri"]["month"]["en"]} ${data["date"]["hijri"]["year"]}",
      prayTime: [
        PrayTime.fromRaw("Fajr", data["timings"]["Fajr"]),
        PrayTime.fromRaw("Sunrise", data["timings"]["Sunrise"]),
        PrayTime.fromRaw("Dhuhr", data["timings"]["Dhuhr"]),
        PrayTime.fromRaw("Asr", data["timings"]["Asr"]),
        PrayTime.fromRaw("Maghrib", data["timings"]["Maghrib"]),
        PrayTime.fromRaw("Isha", data["timings"]["Isha"]),
      ],
    );
  }
}

class PrayTime {
  final String name;
  String time;
  String rowTime;
  String period;
  bool alarm = false;

  PrayTime({
    required this.name,
    required this.rowTime,
    required this.time,
    required this.period,
    required this.alarm,
  });

  void settime(String time) {
    this.rowTime = time;
    final parts = time.split(":");
    int hour = int.parse(parts[0]);

    String minute = parts[1];

    String period = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    if (hour == 0) hour = 12;
    this.time = "$hour:$minute";
    this.period = period;
  }

  factory PrayTime.fromRaw(String name, String rawTime) {
    final parts = rawTime.split(":");

    int hour = int.parse(parts[0]);
    String minute = parts[1];

    String period = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    if (hour == 0) hour = 12;

    return PrayTime(
      name: name,
      rowTime: rawTime,
      time: "$hour:$minute",
      period: period,
      alarm: true,
    );
  }

  void changeAlarm() {
    alarm = !alarm;
  }
}
