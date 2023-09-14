part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class InitDataEvent extends PreferencesEvent {
  final String arg;

  const InitDataEvent(this.arg);
  @override
  List<Object?> get props => [arg];
}
