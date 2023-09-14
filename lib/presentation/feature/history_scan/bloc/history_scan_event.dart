part of 'history_scan_bloc.dart';

abstract class HistoryScanEvent extends Equatable {
  const HistoryScanEvent();
}

class InitDataHistoryEvent extends HistoryScanEvent {

  @override
  List<Object?> get props => [];
}
