import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/domain/entity/details_news_model.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../data/utils/exceptions/api_exception.dart';
import '../../../../../domain/login/usecases/app_usecase.dart';

part 'details_news_event.dart';
part 'details_news_state.dart';

class DetailsNewsBloc extends Bloc<DetailsNewsEvent, DetailsNewsState> {
  DetailsNewsBloc() : super(const DetailsNewsState()) {
    on<DetailsNewsEvent>((event, emit) {});
    on<InitDetailsNewsEvent>((event, emit) async {
      ///todo: api đang lỗi

      final AppUseCase repository = getIt<AppUseCase>();
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final data = await repository.getNewsDetails(event.arg);
        emit(state.copyWith(status: BlocStatusEnum.success, data: data));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
