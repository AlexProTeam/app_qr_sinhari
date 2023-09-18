part of 'login_bloc.dart';

// abstract class LoginEvent extends Equatable {
//   const LoginEvent();
// }

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class InitLoginEvent extends LoginEvent {
  const InitLoginEvent();

  @override
  List<Object?> get props => [];
}

class TapEvent extends LoginEvent {
  final String phone;
  final GlobalKey<FormState> formKey;

  const TapEvent(this.phone, this.formKey);

  @override
  // TODO: implement props
  List<Object?> get props => [phone];
}
