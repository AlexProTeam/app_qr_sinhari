part of 'pay_debt_bloc.dart';

abstract class PayDebtEvent extends Equatable {
  const PayDebtEvent();
}

class InitDataPayEvent extends PayDebtEvent {
  final String? mount;

  const InitDataPayEvent(this.mount);

  @override
  List<Object?> get props => [mount];
}

class OnClickPayEvent extends PayDebtEvent {
  final PaymentDebt? payment;

  const OnClickPayEvent({this.payment});

  @override
  List<Object?> get props => [payment];
}
