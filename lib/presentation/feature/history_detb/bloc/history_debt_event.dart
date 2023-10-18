part of 'history_debt_bloc.dart';

@immutable
abstract class HistoryDebtEvent extends Equatable {
  const HistoryDebtEvent();
}
class InitDebtEvent extends HistoryDebtEvent {
  @override
  List<Object?> get props => [];
}
