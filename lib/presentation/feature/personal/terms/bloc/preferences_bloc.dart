import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/network/client.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/common_util.dart';
import '../../../../../app/route/enum_app_status.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc() : super(const PreferencesState()) {
    on<PreferencesEvent>((event, emit) {});
    on<InitDataEvent>((event, emit) async {
      Map data = {};
      switch (event.arg) {
        case "Screen1":
          try {
            emit(state.copyWith(status: ScreenStatus.loading));
            final data1 = await getIt<AppClient>().post(
              'policy?type=introduce',
              handleResponse: false,
            );
            data = data1['policy'];
            emit(state.copyWith(status: ScreenStatus.success, data: data));
          } catch (e) {
            emit(state.copyWith(status: ScreenStatus.failed));
            CommonUtil.handleException(e, methodName: '');
          }
          break;
        case "Screen2":
          try {
            emit(state.copyWith(status: ScreenStatus.loading));
            final data1 = await getIt<AppClient>().post(
              'policy?type=support_policy',
              handleResponse: false,
            );
            data = data1['policy'];
            emit(state.copyWith(status: ScreenStatus.success, data: data));
          } catch (e) {
            emit(state.copyWith(status: ScreenStatus.failed));
            CommonUtil.handleException(e, methodName: '');
          }
          break;
        case "Screen3":
          try {
            emit(state.copyWith(status: ScreenStatus.loading));
            final data1 = await getIt<AppClient>()
                .post('policy?type=terms', handleResponse: false);
            data = data1['policy'];
            emit(state.copyWith(status: ScreenStatus.success, data: data));
          } catch (e) {
            emit(state.copyWith(status: ScreenStatus.failed));

            CommonUtil.handleException(e, methodName: '');
          }
          break;
      }
    });
  }
}