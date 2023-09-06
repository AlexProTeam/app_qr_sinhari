part of 'list_product_bloc.dart';

class ListProductState extends Equatable {
  final StatusBloc status;
  final List<ProductResponse>? products;

  const ListProductState({
    this.products,
    this.status = StatusBloc.init,
  });

  @override
  List<Object?> get props => [products, status];

  ListProductState copyWith({
    StatusBloc? status,
    List<ProductResponse>? products,
  }) {
    return ListProductState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
