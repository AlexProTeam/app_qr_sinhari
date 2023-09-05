part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final ScreenStatus status;
  final List<NotiModel> histories;

  const NotificationState(
      {this.status = ScreenStatus.init, this.histories = const []});

  NotificationState copyWith(
      {ScreenStatus? status, List<NotiModel>? histories}) {
    return NotificationState(
        status: status ?? this.status, histories: histories ?? this.histories);
  }

  @override
  List<Object?> get props => [status, histories];
}
