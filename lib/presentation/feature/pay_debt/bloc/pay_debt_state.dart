part of 'pay_debt_bloc.dart';

class PayDebtState extends Equatable {
  final BlocStatusEnum? status;
  final PaymentDebt? payment;
  final String? errMes;
  final ObjectResponse? data;

  const PayDebtState({this.status, this.errMes, this.payment, this.data});

  @override
  List<Object?> get props => [status, errMes, payment, data];

  PayDebtState copyWith(
      {BlocStatusEnum? status,
      String? errMes,
      PaymentDebt? payment,
      ObjectResponse? data}) {
    return PayDebtState(
        status: status ?? this.status,
        errMes: errMes ?? this.errMes,
        payment: payment ?? this.payment,
        data: data ?? this.data);
  }
}
