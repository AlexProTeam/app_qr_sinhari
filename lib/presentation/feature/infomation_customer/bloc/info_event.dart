part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class InitListProductEvent extends InfoEvent {
  const InitListProductEvent();

  @override
  List<Object?> get props => [];
}

class ClearListProductEvent extends InfoEvent {
  const ClearListProductEvent();

  @override
  List<Object?> get props => [];
}
