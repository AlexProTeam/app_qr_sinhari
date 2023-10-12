part of 'pay_debt_bloc.dart';

class PayDebtState extends Equatable {
  final BlocStatusEnum? status;
  final PaymentDebt? payment;
  final String? errMes;


  const PayDebtState({this.status, this.errMes, this.payment});

  @override
  List<Object?> get props => [status, errMes, payment];

  PayDebtState copyWith({
    BlocStatusEnum? status,
    String? errMes,
    PaymentDebt? payment
  }) {
    return PayDebtState(
      status: status ?? this.status,
      errMes: errMes ?? this.errMes,
      payment: payment ?? this.payment
    );
  }
}
