import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/enum_app_status.dart';
import '../../../../../common/model/details_news_model.dart';
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
        emit(state.copyWith(status: ScreenStatus.loading));

        final data = await repository.getNewsDetails(event.arg);
        emit(state.copyWith(status: ScreenStatus.success, data: data));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: ScreenStatus.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
