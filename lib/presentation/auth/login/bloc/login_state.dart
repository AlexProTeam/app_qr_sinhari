part of 'login_bloc.dart';

class LoginState extends Equatable {
  final BlocStatusEnum status;
  final String mesErr;

  const LoginState({
    this.status = BlocStatusEnum.init,
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [status, mesErr];

  LoginState copyWith({
    BlocStatusEnum? status,
    String? mesErr,
  }) {
    return LoginState(
      status: status ?? this.status,
      mesErr: mesErr ?? '',
    );
  }
}
