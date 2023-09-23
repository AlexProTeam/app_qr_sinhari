part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final BlocStatusEnum status;
  final List<NotiModel> histories;
  final String errMes;

  const NotificationState({
    this.status = BlocStatusEnum.init,
    this.histories = const [],
    this.errMes = '',
  });

  @override
  List<Object?> get props => [
        status,
        histories,
        errMes,
      ];

  NotificationState copyWith({
    BlocStatusEnum? status,
    List<NotiModel>? histories,
    String? errMes,
  }) {
    return NotificationState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
      errMes: errMes ?? this.errMes,
    );
  }
}
