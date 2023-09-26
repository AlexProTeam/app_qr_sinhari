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
  final String image;

  const OnClickEvent(
    this.name,
    this.mail,
    this.phone,
    this.andres,
    this.image,
  );

  @override
  List<Object?> get props => [
        name,
        mail,
        phone,
        andres,
        image,
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
