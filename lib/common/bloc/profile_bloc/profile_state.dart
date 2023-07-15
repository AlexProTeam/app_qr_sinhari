part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final StatusBloc status;
  final ProfileModel? profileModel;

  const ProfileState({
    this.profileModel,
    this.status = StatusBloc.init,
  });

  @override
  List<Object?> get props => [profileModel, status];

  ProfileState copyWith({
    StatusBloc? status,
    ProfileModel? profileModel,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}
