part of 'verify_bloc.dart';

class VerifyState extends Equatable {
  final BlocStatusEnum status;
  final String mesErr;
  final String token;

  const VerifyState({
    this.status = BlocStatusEnum.init,
    this.mesErr = '',
    this.token = '',
  });

  @override
  List<Object?> get props => [status, mesErr, token];

  VerifyState copyWith({
    BlocStatusEnum? status,
    String? mesErr,
    String? token,
  }) {
    return VerifyState(
      status: status ?? this.status,
      mesErr: mesErr ?? this.mesErr,
      token: token ?? this.token,
    );
  }
}
