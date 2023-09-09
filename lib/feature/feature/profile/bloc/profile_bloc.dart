import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';

import '../../../../common/const/key_save_data_local.dart';
import '../../../../common/local/local_app.dart';
import '../../../../common/model/profile_model.dart';
import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../../re_base/app/di/injector_container.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc1 extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc1() : super(const ProfileState()) {
    on<InitProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ScreenStatus.loading));

        String? accessToken = injector<LocalApp>()
            .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
        AppHeader appHeader = AppHeader();
        appHeader.accessToken = accessToken;
        injector<AppClient>().header = appHeader;

        final data = await injector<AppClient>().get('auth/showProfile');
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

        final client = injector<AppClient>();
        final name = event.nameController;
        final email = event.mailController;
        final phone = event.phoneController;
        final address = event.andressController;

        await client.post(
            'auth/saveProfile?name=$name&email=$email&phone=$phone&address=$address');
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
