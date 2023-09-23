part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class OnClickEvent extends ProfileEvent {
  final String nameController;
  final String mailController;
  final String phoneController;
  final String andressController;
  final String imageController;

  const OnClickEvent(
    this.nameController,
    this.mailController,
    this.phoneController,
    this.andressController,
    this.imageController,
  );

  @override
  List<Object?> get props => [
        nameController,
        mailController,
        phoneController,
        andressController,
        imageController,
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
