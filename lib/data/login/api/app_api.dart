import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/entity/profile_model.dart';
import '../models/request/login_request.dart';
import '../models/response/login_response.dart';

// Project imports:

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST('/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @GET('auth/showProfile')
  Future<ProfileModel> getShowProfile();
}
