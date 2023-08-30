import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/network/client.dart';
import '../../../../../common/utils/common_util.dart';
import '../../../../../common/utils/enum_app_status.dart';
import '../../../../injector_container.dart';
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
        final data = await injector<AppClient>()
            .post('list_news', handleResponse: false);
        data['data'].forEach((e) {
          histories.add(NewsModel.fromJson(e));
        });
        emit(state.copyWith(status: ScreenStatus.success, histories: histories));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
        CommonUtil.handleException(e, methodName: '');
      }
    });
  }
}
