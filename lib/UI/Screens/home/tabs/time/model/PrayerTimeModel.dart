class TimingModel {
  final String date;
  final String weekday;
  final String hijriDate;
  final String day;
  final String fajr;
  final String sunrise;

  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  TimingModel({
    required this.day,
    required this.date,
    required this.weekday,
    required this.hijriDate,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory TimingModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return TimingModel(
      day: data["date"]["gregorian"]["weekday"]["en"],
      date: data["date"]["readable"],
      weekday: data["date"]["gregorian"]["weekday"]["en"],
      hijriDate:
          "${data["date"]["hijri"]["day"]} ${data["date"]["hijri"]["month"]["en"]} ${data["date"]["hijri"]["year"]}",

      fajr: data["timings"]["Fajr"],
      sunrise: data["timings"]["Sunrise"],
      dhuhr: data["timings"]["Dhuhr"],
      asr: data["timings"]["Asr"],
      maghrib: data["timings"]["Maghrib"],
      isha: data["timings"]["Isha"],
    );
  }
}
