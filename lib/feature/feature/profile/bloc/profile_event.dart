part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class OnClickEvent extends ProfileEvent {
  final BuildContext context;
  final TextEditingController nameController;
  final TextEditingController mailController;
  final TextEditingController phoneController;
  final TextEditingController andressController;
  final GlobalKey<FormState> formKey;

  const OnClickEvent(this.context, this.nameController, this.mailController,
      this.phoneController, this.andressController, this.formKey);

  @override
  List<Object?> get props => [
        context,
        nameController,
        mailController,
        phoneController,
        andressController,
        formKey
      ];
}

class OnChooseImageEvent extends ProfileEvent {
  final BuildContext context;

  const OnChooseImageEvent(this.context);
  @override
  List<Object?> get props => [context];
}

class OnSelectImageEvent extends ProfileEvent {
  final bool isCamera;

  const OnSelectImageEvent(this.isCamera);
  @override
  List<Object?> get props => [isCamera];
}

