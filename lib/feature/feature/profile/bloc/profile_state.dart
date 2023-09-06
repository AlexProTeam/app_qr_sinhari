part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final ScreenStatus status;
  final ProfileModel? profileModel;
  final StatusPost statusPost;
  final File? image;

  const ProfileState(
      {this.status = ScreenStatus.loading,
      this.profileModel,
      this.statusPost = StatusPost.loading,
      this.image});

  ProfileState copyWith(
      {ScreenStatus? status,
      ProfileModel? profileModel,
      StatusPost? statusPost,
      File? image}) {
    return ProfileState(
        status: status ?? this.status,
        profileModel: profileModel ?? this.profileModel,
        statusPost: statusPost ?? this.statusPost,
        image: image ?? this.image);
  }

  @override
  List<Object?> get props => [status, profileModel, statusPost, image];
}
