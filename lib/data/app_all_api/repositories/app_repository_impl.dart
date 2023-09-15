// Project imports:

import 'package:dio/dio.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';

import '../../../domain/entity/profile_model.dart';
import '../../../domain/login/repositories/app_repository.dart';
import '../../../presentation/auth/welcome/welcome_model.dart';
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

  @override
  Future<WelcomeModel> getImageIntroduction() async {
    try {
      final response = await api.getImageIntroduction();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<Data> getListFeature() async {
    try {
      final response = await api.getListFeature();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<Data> getListSeller() async {
    try {
      final response = await api.getListSeller();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataDetail> getDetaiProduct(int productId) async {
    try {
      final response = await api.getDetaiProduct(productId);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DetailByQr> getDetaiProductByQr(
      String deviceId, String city, String region, String url) async {
    try {
      final response =
          await api.getDetaiProductByQr(deviceId, city, region, url);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }
}
