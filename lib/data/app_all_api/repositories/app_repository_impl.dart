// Project imports:

import 'package:dio/dio.dart';
import 'package:qrcode/common/model/banner_model.dart';
import 'package:qrcode/common/model/confirm_model.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/response/home_response.dart';
import 'package:qrcode/data/app_all_api/api/app_api.dart';
import 'package:qrcode/data/app_all_api/models/request/login_request.dart';
import 'package:qrcode/data/app_all_api/models/response/login_response.dart';
import 'package:qrcode/data/responses/object_response.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/entity/profile_model.dart';
import 'package:qrcode/domain/login/repositories/app_repository.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_model.dart';
import 'package:qrcode/presentation/feature/history_scan/history_model.dart';
import 'package:qrcode/presentation/feature/news/history_model.dart';

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
  Future<DataProduct> getListFeature() async {
    try {
      final response = await api.getListFeature();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataProduct> getListSeller() async {
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

  @override
  Future<List<BannerResponse>> getBannerHome() async {
    try {
      final response = await api.getBannerHome();

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<HomeCategoryResponse>> getHomeCategory() async {
    try {
      final response = await api.getHomeCategory();

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<NewsModelResponse>> getListNews() async {
    try {
      final response = await api.getListNews();

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<HistoryModel>> getHistoryScanQrCode(
      {required String deviceId}) async {
    try {
      final response = await api.getHistoryScanQrCode(deviceId);

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> requestOtp({required String phone}) async {
    try {
      final response = await api.requestOtp(phone);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ConfirmModel> comfirmOtp(
      {required String phone, required String otp}) async {
    try {
      final response = await api.comfirmOtp(phone, otp);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> addDevice(
      {required String deviceId,}) async {
    try {
      final response = await api.addDevice(deviceId);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }
}
