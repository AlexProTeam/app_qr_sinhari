import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../feature/injector_container.dart';
import '../../const/key_save_data_local.dart';
import '../../const/status_bloc.dart';
import '../../local/local_app.dart';
import '../../model/profile_model.dart';
import '../../network/app_header.dart';
import '../../network/client.dart';
import '../../utils/common_util.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<InitProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusBloc.loading));

        String? accessToken = injector<LocalApp>()
            .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
        AppHeader appHeader = AppHeader();
        appHeader.accessToken = accessToken;
        injector<AppClient>().header = appHeader;

        final data = await injector<AppClient>().get('auth/showProfile');
        ProfileModel profileModel = ProfileModel.fromJson(data['data']);

        emit(state.copyWith(
          status: StatusBloc.success,
          profileModel: profileModel,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: StatusBloc.failed,
        ));
        CommonUtil.handleException(e, methodName: '');
      }
    });

    on<ClearProfileEvent>((event, emit) async {
      emit(state.copyWith(
        profileModel: ProfileModel(),
      ));
    });
  }
}
