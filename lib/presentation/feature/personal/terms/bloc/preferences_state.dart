part of 'preferences_bloc.dart';

class PreferencesState extends Equatable {
  final ScreenStatus status;
  final Introduce? data;

  const PreferencesState({this.status = ScreenStatus.loading, this.data});

  PreferencesState copyWith({ScreenStatus? status, Introduce? data}) {
    return PreferencesState(
        status: status ?? this.status, data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, data];
}