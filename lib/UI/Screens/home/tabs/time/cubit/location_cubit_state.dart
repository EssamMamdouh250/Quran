import 'package:meta/meta.dart';

@immutable
sealed class LocationCubitState {}

final class LocationInitial extends LocationCubitState {}

final class LocationLoading extends LocationCubitState {}

final class LocationLoaded extends LocationCubitState {
  LocationLoaded();
}

final class LocationError extends LocationCubitState {
  final String message;

  LocationError(this.message);
}
