import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/common_util.dart';
import '../../../../../app/route/enum_app_status.dart';
import '../../../../../common/network/client.dart';
import '../../history_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState()) {
    on<NewsEvent>((event, emit) {});

    on<InitNewsDataEvent>((event, emit) async {
      List<NewsModel> histories = [];
      try {
        emit(state.copyWith(status: ScreenStatus.loading));
        final data =
            await getIt<AppClient>().post('list_news', handleResponse: false);
        data['data'].forEach((e) {
          histories.add(NewsModel.fromJson(e));
        });
        emit(
            state.copyWith(status: ScreenStatus.success, histories: histories));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
        CommonUtil.handleException(e, methodName: '');
      }
    });
  }
}
