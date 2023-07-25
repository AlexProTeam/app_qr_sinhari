part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitProfileEvent extends ProfileEvent {
  const InitProfileEvent();

  @override
  List<Object?> get props => [];
}

class ClearProfileEvent extends ProfileEvent {
  const ClearProfileEvent();

  @override
  List<Object?> get props => [];
}
