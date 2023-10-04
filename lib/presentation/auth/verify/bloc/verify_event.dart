part of 'verify_bloc.dart';

abstract class VerifyEvent extends Equatable {
  const VerifyEvent();
}

class InitLoginEvent extends VerifyEvent {
  const InitLoginEvent();

  @override
  List<Object?> get props => [];
}

class TapEvent extends VerifyEvent {
  final String phone;
  final GlobalKey<FormState> formKey;
  final String otp;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TapEvent(
      this.phone, this.formKey, this.otp, this.controller, this.focusNode);

  @override
  // TODO: implement props
  List<Object?> get props => [phone, formKey, otp, controller, focusNode];
}
