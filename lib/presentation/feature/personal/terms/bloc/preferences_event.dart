part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class InitPreferencesEvent extends PreferencesEvent {
  final PolicyEnum policyEnum;

  const InitPreferencesEvent(this.policyEnum);
  @override
  List<Object?> get props => [policyEnum];
}
