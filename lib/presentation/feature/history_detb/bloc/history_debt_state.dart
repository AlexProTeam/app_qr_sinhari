part of 'history_debt_bloc.dart';

@immutable
class HistoryDebtState extends Equatable {
  final BlocStatusEnum? status;
  final HistoryDebtModel? debtModel;
  final String message;

  const HistoryDebtState({
    this.status,
    this.debtModel,
    this.message = '',
  });

  @override
  List<Object?> get props => [status, debtModel, message];

  HistoryDebtState copyWith({
    BlocStatusEnum? status,
    HistoryDebtModel? debtModel,
    String? message,
  }) {
    return HistoryDebtState(
      status: status ?? this.status,
      debtModel: debtModel ?? this.debtModel,
      message: message ?? this.message,
    );
  }
}
