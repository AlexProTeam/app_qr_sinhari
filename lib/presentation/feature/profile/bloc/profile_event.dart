part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class OnClickEvent extends ProfileEvent {
  final String name;
  final String mail;
  final String phone;
  final String andres;
  final bool isHasChangeAvatar;

  const OnClickEvent(
    this.name,
    this.mail,
    this.phone,
    this.andres,
    this.isHasChangeAvatar,
  );

  @override
  List<Object?> get props => [
        name,
        mail,
        phone,
        andres,
        isHasChangeAvatar,
      ];
}

class OnSelectImageEvent extends ProfileEvent {
  final String? filePath;

  const OnSelectImageEvent(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class ClearProfileEvent extends ProfileEvent {
  const ClearProfileEvent();

  @override
  List<Object?> get props => [];
}

class DeleteAccountEvent extends ProfileEvent {
  const DeleteAccountEvent();

  @override
  List<Object?> get props => [];
}
