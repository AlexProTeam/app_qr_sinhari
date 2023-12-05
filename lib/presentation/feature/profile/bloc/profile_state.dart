part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final BlocStatusEnum status;
  final ProfileModel? profileModel;
  final String image;
  final String mes;
  final bool? isDeleteAccount;

  const ProfileState({
    this.status = BlocStatusEnum.loading,
    this.profileModel,
    this.image = '',
    this.mes = '',
    this.isDeleteAccount,
  });

  @override
  List<Object?> get props => [
        status,
        profileModel,
        image,
        mes,
        isDeleteAccount,
      ];

  ProfileState copyWith({
    BlocStatusEnum? status,
    ProfileModel? profileModel,
    String? image,
    String? mes,
    bool? deleteAccount,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel,
      image: image ?? this.image,
      mes: mes ?? '',
      isDeleteAccount: deleteAccount,
    );
  }

  bool get isHasProfileData => profileModel?.phone != null;
}
