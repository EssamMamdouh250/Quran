import 'package:meta/meta.dart';

@immutable
sealed class LocationCubitState {}

final class LocationInitial extends LocationCubitState {}

final class LocationLoaded extends LocationCubitState {
  final String city;
  final String country;
  LocationLoaded(this.city, this.country);
}

final class LocationError extends LocationCubitState {
  final String message;

  LocationError(this.message);
}
