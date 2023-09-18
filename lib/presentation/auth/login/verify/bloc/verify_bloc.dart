import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/di/injection.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/app/utils/session_utils.dart';
import 'package:qrcode/common/bloc/profile_bloc/profile_bloc.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';
import 'package:qrcode/presentation/feature/bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import 'package:qrcode/presentation/feature/bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

part 'verify_event.dart';

part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AppUseCase appUseCase;
  final BuildContext context;

  VerifyBloc(this.appUseCase, this.context) : super(const VerifyState()) {
    on<TapEvent>((event, emit) async {
      try {
        if (event.controller.text.isEmpty) {
          return await ToastManager.showToast(
            context,
            text: 'bạn chưa nhập mã',
            delaySecond: 1,
          );
        } else if (event.controller.text.length < 6) {
          return await ToastManager.showToast(
            context,
            text: 'Chưa nhập đủ mã',
            delaySecond: 1,
          );
        } else {
          emit(state.copyWith(status: BlocStatusEnum.loading));
          await onContinue(context, event.phone, event.otp, event.focusNode);
          emit(state.copyWith(
            status: BlocStatusEnum.success,
          ));
        }
      } catch (e) {
        await ToastManager.showToast(
          context,
          text: 'Mã không đúng',
        );
        event.controller.clear();
        // emit(state.copyWith(
        //   status: BlocStatusEnum.failed,
        // ));
     //   CommonUtil.handleException(e, methodName: '');
      }
    });
  }

  Future<void> onContinue(BuildContext context, String phone, String otp,
      FocusNode focusNode) async {
    // if (!CommonUtil.validateAndSave(_formKey)) return;
    // if (_controller.text.isEmpty) {
    //   return await ToastManager.showToast(
    //     context,
    //     text: 'bạn chưa nhập mã',
    //     delaySecond: 1,
    //   );
    // }
    // if (_controller.text.length < 6) {
    //   return await ToastManager.showToast(
    //     context,
    //     text: 'Chưa nhập đủ mã',
    //     delaySecond: 1,
    //   );
    // }
    AppHeader appHeader = AppHeader();
    await appUseCase.comfirmOtp(phone, otp).then((value) => {
          if (value.success == true)
            {
              appHeader.accessToken = value.data?.result?.accessToken,
              getIt<AppClient>().header = appHeader,
              SessionUtils.saveAccessToken(
                  value.data?.result?.accessToken ?? ''),
              context.read<ProfileBloc>().add(const InitProfileEvent()),
              focusNode.unfocus(),
              context.read<BottomBarBloc>().add(const ChangeTabBottomBarEvent(
                    bottomBarEnum: BottomBarEnum.home,
                    isRefresh: true,
                  )),
              Navigator.popUntil(context, (route) => route.isFirst)
            }
        });
  }
}
