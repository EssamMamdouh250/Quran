import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran/UI/Screens/home/tabs/time/repos/Timing_Repo.dart';
import 'package:quran/UI/Screens/home/tabs/time/model/PrayerTimeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'aladan_state.dart';

class AladanCubit extends Cubit<AladanState> {
  final TimingRepe repository;

  AladanCubit(this.repository) : super(AladanInitial());

  Future<void> getTimes() async {
    print("object11");
    emit(AladanInitial());
    try {
      print("object22");

      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool hasLocation = prefs.getBool("havelocation") ?? false;

      if (!hasLocation) {
        emit(AladanError("Location not set yet"));
        return;
      }

      if (hasLocation) {
        String? city = prefs.getString("city");
        String? country = prefs.getString("country");

        if (city == null || country == null) {
          emit(AladanError("Missing location data"));
          return;
        }
        final times = await repository.getTimes(city, country);
        emit(AladanLoaded(times));
      } else {}
    } catch (e) {
      emit(AladanError(e.toString()));
    }
  }
}
