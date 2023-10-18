part of 'history_debt_bloc.dart';

@immutable
class HistoryDebtState extends Equatable {
  final BlocStatusEnum? status;
  final HistoryDebtModel? debtModel;

  const HistoryDebtState({this.status, this.debtModel});

  @override
  List<Object?> get props => [status, debtModel];

  HistoryDebtState copyWith({
    BlocStatusEnum? status,
    HistoryDebtModel? debtModel
  }) {
    return HistoryDebtState(status: status ?? this.status, debtModel: debtModel ?? this.debtModel);
  }
}
