import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/app/route/common_util.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';
import 'package:qrcode/firebase/firebase_config.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppUseCase appUseCase;
  final BuildContext context;

  LoginBloc(this.appUseCase, this.context) : super(const LoginState()) {
    on<TapEvent>((event, emit) async {
      try {
        if (!CommonUtil.validateAndSave(event.formKey)) {
          // String phoneNumber = text[0] != '0' ? '0$text' : text;
          return;
        } else {
          emit(state.copyWith(status: BlocStatusEnum.loading));
          await _performLogin(event.phone, context);
          emit(state.copyWith(
            status: BlocStatusEnum.success,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
        ));
        CommonUtil.handleException(e, methodName: '');
      }
    });
  }

  Future<void> _performLogin(String phoneNumber, BuildContext context) async {
    try {
      await appUseCase.requestOtp(phoneNumber).then((value) {
        if (value.success == true) {
          Navigator.pushNamed(
            context,
            RouteDefine.verifyOtpScreen,
            arguments: phoneNumber,
          );
        }
      });
      final token = await FirebaseConfig.getTokenFcm();
      await appUseCase.addDevice(token ?? '');
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
  }
}
