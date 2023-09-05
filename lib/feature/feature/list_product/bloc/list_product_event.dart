part of 'list_product_bloc.dart';

abstract class ListProductEvent extends Equatable {
  const ListProductEvent();
}

// class ProductsEvent extends ListProductEvent {
//   final String? url;
//   final String? label;
//
//   const ProductsEvent(this.url, this.label);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

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
