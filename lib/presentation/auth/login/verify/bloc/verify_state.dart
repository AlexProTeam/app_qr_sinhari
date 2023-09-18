part of 'verify_bloc.dart';

class VerifyState extends Equatable {
  final BlocStatusEnum status;

  const VerifyState({
    this.status = BlocStatusEnum.init,
  });

  @override
  List<Object?> get props => [status];

  VerifyState copyWith({
    BlocStatusEnum? status,
    List<ProductResponse>? products,
  }) {
    return VerifyState(
      status: status ?? this.status,
    );
  }
}
