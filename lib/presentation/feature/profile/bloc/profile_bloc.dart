import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/network/app_header.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/route/common_util.dart';
import '../../../../app/route/enum_app_status.dart';
import '../../../../app/utils/session_utils.dart';
import '../../../../common/network/client.dart';
import '../../../../domain/entity/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc1 extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc1() : super(const ProfileState()) {
    on<InitProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ScreenStatus.loading));

        AppHeader appHeader = AppHeader();
        appHeader.accessToken = SessionUtils.accessToken;
        getIt<AppClient>().header = appHeader;

        final data = await getIt<AppClient>().get('auth/showProfile');
        ProfileModel profileModel = ProfileModel.fromJson(data['data']);

        emit(state.copyWith(
          status: ScreenStatus.success,
          profileModel: profileModel,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ScreenStatus.failed,
        ));
        CommonUtil.handleException(e, methodName: '');
      }
    });
    on<OnClickEvent>((event, emit) async {
      try {
        emit(state.copyWith(statusPost: StatusPost.loading));

        final client = getIt<AppClient>();
        final name = event.nameController;
        final email = event.mailController;
        final phone = event.phoneController;
        final address = event.andressController;
        final image = event.imageController;

        await client.post(
            'auth/saveProfile?name=$name&email=$email&phone=$phone&address=$address',
            body: File(image));
        emit(state.copyWith(statusPost: StatusPost.success));
      } catch (e) {
        emit(state.copyWith(statusPost: StatusPost.failed));
      }
    });

    on<OnSelectImageEvent>((event, emit) async {
      emit(state.copyWith(image: event.filePath));
    });
  }
}
