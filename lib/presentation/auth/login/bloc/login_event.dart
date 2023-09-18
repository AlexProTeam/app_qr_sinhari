part of 'login_bloc.dart';

// abstract class LoginEvent extends Equatable {
//   const LoginEvent();
// }

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class AddDeviceLoginEvent extends LoginEvent {
  const AddDeviceLoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithOtpEvent extends LoginEvent {
  final String phone;

  const LoginWithOtpEvent(this.phone);

  @override
  List<Object?> get props => [phone];
}
