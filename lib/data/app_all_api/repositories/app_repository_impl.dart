// Project imports:

import 'package:dio/dio.dart';

import '../../../domain/entity/profile_model.dart';
import '../../../domain/login/repositories/app_repository.dart';
import '../../utils/exceptions/api_exception.dart';
import '../api/app_api.dart';
import '../models/request/login_request.dart';
import '../models/response/login_response.dart';

class AppRepositoryImpl implements AppRepository {
  final AppApi api;

  AppRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    await api
        .login(request)
        .catchError((e, stack) => throw ApiException.error(e, stack));
    await Future.delayed(const Duration(seconds: 3));

    return const LoginResponse(
      userName: "UserName",
      userPhone: "phone",
      email: "email",
    );
  }

  @override
  Future<ProfileModel> getShowProfile() async {
    try {
      final response = await api.getShowProfile();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }
}
