part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final BlocStatusEnum status;
  final ProfileModel? profileModel;
  final String? mesErr;

  const ProfileState({
    this.profileModel,
    this.status = BlocStatusEnum.init,
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [
        profileModel,
        status,
        mesErr,
      ];

  ProfileState copyWith({
    BlocStatusEnum? status,
    ProfileModel? profileModel,
    String? mesErr,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel ?? this.profileModel,
      mesErr: mesErr ?? '',
    );
  }
}
