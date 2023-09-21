part of 'preferences_bloc.dart';

class PreferencesState extends Equatable {
  final BlocStatusEnum status;
  final IntroduceResponse? data;
  final String mesErr;

  const PreferencesState({
    this.status = BlocStatusEnum.loading,
    this.data,
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [status, data, mesErr];

  PreferencesState copyWith({
    BlocStatusEnum? status,
    IntroduceResponse? data,
    String? mesErr,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      data: data ?? this.data,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
