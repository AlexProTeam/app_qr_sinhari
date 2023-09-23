part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class InitNotification extends NotificationEvent {
  @override
  List<Object?> get props => [];
}
