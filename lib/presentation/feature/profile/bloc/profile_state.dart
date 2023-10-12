part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final BlocStatusEnum status;
  final ProfileModel? profileModel;
  final String image;
  final String mes;

  const ProfileState({
    this.status = BlocStatusEnum.loading,
    this.profileModel,
    this.image = '',
    this.mes = '',
  });

  @override
  List<Object?> get props => [
        status,
        profileModel,
        image,
        mes,
      ];

  ProfileState copyWith({
    BlocStatusEnum? status,
    ProfileModel? profileModel,
    String? image,
    String? mes,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel,
      image: image ?? this.image,
      mes: mes ?? '',
    );
  }

  bool get isHasProfileData => profileModel?.phone != null;
}
