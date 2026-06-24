part of 'aladan_cubit.dart';

@immutable
sealed class AladanState {}

final class AladanInitial extends AladanState {}

final class AladanLoaded extends AladanState {
  final TimingModel times;

  AladanLoaded(this.times);
}

final class AladanError extends AladanState {
  final String errorMsg;

  AladanError(this.errorMsg);
}
