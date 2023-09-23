part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();
}

class InitWelcomeEvent extends WelcomeEvent {
  const InitWelcomeEvent();

  @override
  List<Object?> get props => [];
}
