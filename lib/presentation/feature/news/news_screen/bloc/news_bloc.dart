import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/common_util.dart';
import '../../../../../app/route/enum_app_status.dart';
import '../../history_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState()) {
    on<NewsEvent>((event, emit) {});

    on<InitNewsDataEvent>((event, emit) async {
      final AppUseCase repository = getIt<AppUseCase>();
      try {
        emit(state.copyWith(status: ScreenStatus.loading));
        final data = await repository.getListNews();
        emit(state.copyWith(status: ScreenStatus.success, histories: data));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
        CommonUtil.handleException(e, methodName: '');
      }
    });
  }
}
