import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/location_cubit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationCubitState> {
  LocationCubit() : super(LocationInitial());

  Future<void> getUserLocation() async {
    emit(LocationLoading());

    try {
      print(1);
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
      print(2);

        emit(LocationError("Location services are disabled"));
      }
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
      print(3);
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError("Location permissions are permanently denied"));
      }
      print("serviceEnabled: $serviceEnabled");
      print("permission: $permission");

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      String city = place.locality ?? "";
      String country = place.country ?? "";

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("city", city);
      await prefs.setString("country", country);
      await prefs.setBool("havelocation", true);

      print("done");

      emit(LocationLoaded());
    } catch (e) {
      print("ERROR: $e");
      emit(LocationError(e.toString()));
    }
  }
}
