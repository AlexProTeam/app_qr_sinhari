import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/common_util.dart';
import '../../../../../app/route/enum_app_status.dart';
import '../../../../../common/model/details_news_model.dart';
import '../../../../../domain/login/usecases/app_usecase.dart';

part 'details_news_event.dart';
part 'details_news_state.dart';

class DetailsNewsBloc extends Bloc<DetailsNewsEvent, DetailsNewsState> {
  DetailsNewsBloc() : super(const DetailsNewsState()) {
    on<DetailsNewsEvent>((event, emit) {});
    on<InitDetailsNewsEvent>((event, emit) async {
      Map data = {};
      final AppUseCase repository = getIt<AppUseCase>();
      try {
        emit(state.copyWith(status: ScreenStatus.loading));

        // var request = http.MultipartRequest('POST',
        //     Uri.parse('https://beta.sinhairvietnam.vn/api/news_detail'));
        // request.fields.addAll({'news_id': '${event.arg}'});
        //
        // http.StreamedResponse response = await request.send();
        // if (response.statusCode == 200) {
        //   final test = await response.stream.bytesToString();
        //   data.addAll(json.decode(test)['data']);
        final data = await repository.getNewsDetails(event.arg);
          emit(state.copyWith(status: ScreenStatus.success, data: data));
        // }
        emit(state.copyWith(status: ScreenStatus.failed));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
        CommonUtil.handleException(e, methodName: '');
      }
    });
  }
}
