import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/enum_app_status.dart';
import '../../../../../data/utils/exceptions/api_exception.dart';
import '../../history_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final AppUseCase repository = getIt<AppUseCase>();

  NewsBloc() : super(const NewsState()) {
    on<NewsEvent>((event, emit) {});

    on<InitNewsDataEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ScreenStatus.loading));
        final data = await repository.getListNews();
        emit(state.copyWith(
          status: ScreenStatus.success,
          histories: data,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: ScreenStatus.failed,
          mesErr: e.message,
        ));
      }
    });
  }
}
