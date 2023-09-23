part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  final WelcomeModel? welcomeModel;
  final BlocStatusEnum status;
  final String errMes;

  const WelcomeState({
    this.welcomeModel,
    this.status = BlocStatusEnum.init,
    this.errMes = '',
  });

  @override
  List<Object?> get props => [welcomeModel, status, errMes];

  WelcomeState copyWith({
    WelcomeModel? welcomeModel,
    BlocStatusEnum? status,
    String? errMes,
  }) {
    return WelcomeState(
      welcomeModel: welcomeModel ?? this.welcomeModel,
      status: status ?? this.status,
      errMes: errMes ?? '',
    );
  }
}
