part of 'login_bloc.dart';

class LoginState extends Equatable {
  final BlocStatusEnum status;
 // final List<ProductResponse>? products;

  const LoginState({
  //  this.products,
    this.status = BlocStatusEnum.init,
  });

  @override
  List<Object?> get props => [ status];

  LoginState copyWith({
    BlocStatusEnum? status,
    List<ProductResponse>? products,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}
