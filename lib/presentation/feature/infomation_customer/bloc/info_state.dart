part of 'info_bloc.dart';

class InfoState extends Equatable {
  final BlocStatusEnum status;
  final List<OrdersHistoryResponse>? products;
  final String? statusFill;
  final String mesErr;

  const InfoState({
    this.products,
    this.status = BlocStatusEnum.loading,
    this.mesErr = '',
    this.statusFill,
  });

  @override
  List<Object?> get props => [
        products,
        status,
        mesErr,
        statusFill,
      ];

  InfoState copyWith({
    BlocStatusEnum? status,
    List<OrdersHistoryResponse>? products,
    String? mesErr,
  }) {
    return InfoState(
      status: status ?? this.status,
      products: products ?? this.products,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
