part of 'detail_order_bloc.dart';

class DetailOrderState extends Equatable {
  final BlocStatusEnum status;
  final DataOrderDetail? dataOrderDetail;
  final String errMes;

  const DetailOrderState({
    this.dataOrderDetail,
    this.status = BlocStatusEnum.init,
    this.errMes = '',
  });

  @override
  List<Object?> get props => [
        dataOrderDetail,
        status,
        errMes,
      ];

  DetailOrderState copyWith(
      {BlocStatusEnum? status,
      DataOrderDetail? dataOrderDetail,
      String? errMes,
      OrderCartsResponse? addToCartModel}) {
    return DetailOrderState(
      status: status ?? this.status,
      dataOrderDetail: dataOrderDetail ?? this.dataOrderDetail,
      errMes: errMes ?? '',
    );
  }
}
