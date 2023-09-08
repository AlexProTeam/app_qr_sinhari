import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_details_news_event.dart';
part 'bloc_details_news_state.dart';

class DetailsNewsBloc extends Bloc<DetailsNewsEvent, DetailsNewsState> {
  DetailsNewsBloc() : super(DetailsNewsInitial()) {
    on<DetailsNewsEvent>((event, emit) {
      // _initData();
    });
  }
}

// void _initData() async {
//   try {
//     // isLoadding = true;
//
//     ///todo: change to base later
//
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('https://beta.sinhairvietnam.vn/api/news_detail'));
//     request.fields.addAll({'news_id': '${widget.argument?.newsDetail}'});
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final test = await response.stream.bytesToString();
//       _data = json.decode(test)['data'];
//     }
//   } catch (e) {
//     CommonUtil.handleException(e, methodName: '');
//   }
//     // isLoadding = false;
// }
