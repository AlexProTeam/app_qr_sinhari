part of 'history_debt_bloc.dart';

@immutable
class HistoryDebtState extends Equatable {
  final BlocStatusEnum? status;

  const HistoryDebtState({this.status});

  @override
  List<Object?> get props => [status];

  HistoryDebtState copyWith({
    BlocStatusEnum? status,
  }) {
    return HistoryDebtState(status: status ?? this.status);
  }
}
