part of 'preferences_bloc.dart';

class PreferencesState extends Equatable {
  final ScreenStatus status;
  final Map data;

  const PreferencesState(
      {this.status = ScreenStatus.loading, this.data = const {}});

  PreferencesState copyWith({ScreenStatus? status, Map? data}) {
    return PreferencesState(
        status: status ?? this.status, data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, data];
}