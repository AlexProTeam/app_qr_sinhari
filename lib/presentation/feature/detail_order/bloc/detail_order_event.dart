part of 'detail_order_bloc.dart';

abstract class DetailOrderEvent extends Equatable {
  const DetailOrderEvent();
}

class InitDetailOrderEvent extends DetailOrderEvent {
  final int id;

  const InitDetailOrderEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class ClearProductDetailEvent extends DetailOrderEvent {
  const ClearProductDetailEvent();

  @override
  List<Object?> get props => [];
}
