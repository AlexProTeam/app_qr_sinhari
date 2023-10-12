part of 'list_product_bloc.dart';

abstract class ListProductEvent extends Equatable {
  const ListProductEvent();
}

class InitDataListProductEvent extends ListProductEvent {
  const InitDataListProductEvent();

  @override
  List<Object?> get props => [];
}

class ClearListProductEvent extends ListProductEvent {
  const ClearListProductEvent();

  @override
  List<Object?> get props => [];
}
