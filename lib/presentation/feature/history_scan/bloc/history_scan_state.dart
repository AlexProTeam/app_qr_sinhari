part of 'history_scan_bloc.dart';

class HistoryScanState extends Equatable {
  final BlocStatusEnum status;
  final List<HistoryModel> histories;

  const HistoryScanState(
      {this.histories = const [], this.status = BlocStatusEnum.loading});

  HistoryScanState copyWith(
      {BlocStatusEnum? status, List<HistoryModel>? histories}) {
    return HistoryScanState(
        status: status ?? this.status, histories: histories ?? this.histories);
  }

  @override
  List<Object?> get props => [status, histories];
}
