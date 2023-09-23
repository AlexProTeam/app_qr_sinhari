part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final BlocStatusEnum status;
  final ProfileModel? profileModel;
  final String image;
  final String errMes;

  const ProfileState({
    this.status = BlocStatusEnum.loading,
    this.profileModel,
    this.image = '',
    this.errMes = '',
  });

  @override
  List<Object?> get props => [
        status,
        profileModel,
        image,
        errMes,
      ];

  ProfileState copyWith({
    BlocStatusEnum? status,
    ProfileModel? profileModel,
    String? image,
    String? errMes,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel,
      image: image ?? this.image,
      errMes: errMes ?? this.errMes,
    );
  }
}
