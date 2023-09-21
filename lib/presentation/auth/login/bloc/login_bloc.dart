import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/domain/all_app_doumain/usecases/app_usecase.dart';
import 'package:qrcode/firebase/firebase_config.dart';

import '../../../../data/utils/exceptions/api_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  LoginBloc() : super(const LoginState()) {
    on<LoginWithOtpEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        await _appUseCase.requestOtp(event.phone);
        //todo: check lại với khách có cần gửi fcm token ở đây không
        final token = await FirebaseConfig.getTokenFcm();
        await _appUseCase.addDevice(token ?? '');
        emit(state.copyWith(
          status: BlocStatusEnum.success,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          mesErr: e.message,
        ));
      }
    });
  }
}
