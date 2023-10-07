part of 'info_bloc.dart';

class InfoState extends Equatable {
  final BlocStatusEnum status;
  final List<OrderModel>? products;
  final String mesErr;

  const InfoState({
    this.products,
    this.status = BlocStatusEnum.loading,
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [
        products,
        status,
        mesErr,
      ];

  InfoState copyWith({
    BlocStatusEnum? status,
    List<OrderModel>? products,
    String? mesErr,
  }) {
    return InfoState(
      status: status ?? this.status,
      products: products ?? this.products,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
