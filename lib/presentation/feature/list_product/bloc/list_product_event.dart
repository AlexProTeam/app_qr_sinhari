part of 'list_product_bloc.dart';

abstract class ListProductEvent extends Equatable {
  const ListProductEvent();
}

class InitListProductEvent extends ListProductEvent {
  const InitListProductEvent();

  @override
  List<Object?> get props => [];
}

class ClearListProductEvent extends ListProductEvent {
  const ClearListProductEvent();

  @override
  List<Object?> get props => [];
}
