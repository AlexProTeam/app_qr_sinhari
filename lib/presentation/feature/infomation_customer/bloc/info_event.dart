part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class InitListProductEvent extends InfoEvent {
  final String? status;

  const InitListProductEvent({this.status});

  @override
  List<Object?> get props => [status];
}

class ClearListProductEvent extends InfoEvent {
  const ClearListProductEvent();

  @override
  List<Object?> get props => [];
}
