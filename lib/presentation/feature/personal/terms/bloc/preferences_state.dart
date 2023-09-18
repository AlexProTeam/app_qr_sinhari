part of 'preferences_bloc.dart';

class PreferencesState extends Equatable {
  final ScreenStatus status;
  final Introduce? data;
  final String mesErr;

  const PreferencesState({
    this.status = ScreenStatus.loading,
    this.data,
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [status, data, mesErr];

  PreferencesState copyWith({
    ScreenStatus? status,
    Introduce? data,
    String? mesErr,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      data: data ?? this.data,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
