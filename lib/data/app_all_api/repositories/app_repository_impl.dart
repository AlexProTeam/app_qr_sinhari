// Project imports:

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/data/app_all_api/api/app_api.dart';
import 'package:qrcode/data/app_all_api/models/request/login_request.dart';
import 'package:qrcode/data/app_all_api/models/response/login_response.dart';
import 'package:qrcode/data/responses/object_response.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/entity/add_to_cart_model.dart';
import 'package:qrcode/domain/entity/banner_model.dart';
import 'package:qrcode/domain/entity/confirm_model.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/domain/entity/details_news_model.dart';
import 'package:qrcode/domain/entity/home_response.dart';
import 'package:qrcode/domain/entity/introduce_model.dart';
import 'package:qrcode/domain/entity/noti_model.dart';
import 'package:qrcode/domain/entity/order_model.dart';
import 'package:qrcode/domain/entity/payment_debt_model.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/domain/entity/profile_model.dart';
import 'package:qrcode/domain/entity/welcome_model.dart';
import 'package:qrcode/presentation/feature/history_scan/history_model.dart';
import 'package:qrcode/presentation/feature/news/history_model.dart';

import '../../../domain/entity/address_screen.dart';
import '../../../domain/entity/confirm_cart_response.dart';
import '../../../domain/entity/detail_order_response.dart';
import '../../../domain/entity/history_debt_model.dart';
import '../../../domain/entity/list_carts_response.dart';
import '../models/request/confirm_job_request.dart';
import '../models/request/update_address.dart';

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

      return response.data ?? ProfileModel();
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
  Future<NewsDetails> getNewsDetails({required int idNews}) async {
    try {
      final response = await api.getDetailsNews(idNews);
      return response.data ?? NewsDetails();
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
  Future<ConfirmModel> comfirmOtp({
    required String phone,
    required String otp,
    required String deviceId,
  }) async {
    try {
      final response = await api.comfirmOtp(phone, otp, deviceId);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> addDevice({
    required String deviceId,
  }) async {
    try {
      final response = await api.addDevice(deviceId);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<IntroduceResponse> getSupportPolicy(String policyType) async {
    try {
      final response = await api.policy(policyType);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse<ProfileModel>> saveProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
  }) async {
    try {
      final response = await api.saveProfile(name, email, phone, address);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse<ProfileModel>> saveProfileAvatar({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
    required File avatar,
  }) async {
    try {
      final response =
          await api.saveProfileAvatar(name, email, phone, address, avatar);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<NotiResponse>> getNotifications() async {
    try {
      final response = await api.getNotifications();
      return response.notifications ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> saveContact({
    String? productId,
    String? content,
    int? type,
  }) async {
    try {
      final response = await api.saveContact(productId, content, type);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<OrderCartsResponse> addToCart({
    int? productId,
  }) async {
    try {
      final response = await api.addToCart(productId ?? 0);
      return response.data ?? OrderCartsResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ListCartsResponse> getListCart() async {
    try {
      final response = await api.getListCart();
      return response.data ?? ListCartsResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataProduct> getListAngecy() async {
    try {
      final response = await api.getListAngecy();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataListOrder> getListOrder({String? statusOrder}) async {
    try {
      final response = await api.getListOrder(statusOrder);

      return response.data ?? DataListOrder();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse<PaymentDebt>> payment({int? amount}) async {
    try {
      final response = await api.postPayment(amount ?? 0);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<OrderCartsResponse> changeQuality({int? productId, int? qty}) async {
    try {
      final response = await api.postQuality(productId ?? 0, qty ?? 0);
      return response.data ?? OrderCartsResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ConfirmCartResponse> confirmCart(
    ConfirmCartRequest confirmCartRequest,
  ) async {
    try {
      final response = await api.postConfirmCart(confirmCartRequest);
      return response.data ?? ConfirmCartResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> deleteItemCart(int id) async {
    try {
      return await api.deleteItemCart(id);
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse<DataOrderDetail>> getDetailOrder(int? proId) async {
    try {
      return await api.getDetailOrder(proId);
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<HistoryDebtResponse> getListDebt() async {
    try {
      final result = await api.getListDebt();
      return result.data ?? HistoryDebtResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> paymentConfirm() async {
    try {
      final result = await api.paymentConfirm();
      return result;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<AddressResponse>> getListAddress() async {
    try {
      final result = await api.getListAddress();
      return result.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<AddressResponse> updateAddress(
    CUAddressRequest updateAddressRequest,
  ) async {
    try {
      final result = await api.updateAddress(updateAddressRequest);
      return result.data ?? AddressResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<AddressResponse> createAddress(
    CUAddressRequest updateAddressRequest,
  ) async {
    try {
      final result = await api.createAddress(updateAddressRequest);
      return result.data ?? AddressResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> deleteAddress(
    int addressId,
  ) async {
    try {
      final result = await api.deleteAddress(addressId);
      return result;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<AddressResponse> detailAddress(
    int id,
  ) async {
    try {
      final result = await api.detailAddress(id);
      return result.data ?? AddressResponse();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> detailAccount() async {
    try {
      final result = await api.detailAccount();
      return result;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }
}
