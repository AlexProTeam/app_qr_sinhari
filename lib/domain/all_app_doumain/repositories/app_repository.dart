// Project imports:
import 'dart:io';

import 'package:qrcode/data/responses/object_response.dart';
import 'package:qrcode/domain/entity/Introduce_model.dart';
import 'package:qrcode/domain/entity/confirm_model.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/domain/entity/details_news_model.dart';
import 'package:qrcode/domain/entity/home_response.dart';
import 'package:qrcode/domain/entity/noti_model.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/domain/entity/welcome_model.dart';

import '../../../data/app_all_api/models/request/login_request.dart';
import '../../../data/app_all_api/models/response/login_response.dart';
import '../../../presentation/feature/history_scan/history_model.dart';
import '../../../presentation/feature/news/history_model.dart';
import '../../entity/banner_model.dart';
import '../../entity/profile_model.dart';

abstract class AppRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<ProfileModel> getShowProfile();

  Future<WelcomeModel> getImageIntroduction();

  Future<DataProduct> getListFeature();

  Future<DataProduct> getListSeller();

  Future<DataDetail> getDetaiProduct(int productId);

  Future<DetailByQr> getDetaiProductByQr(
      String deviceId, String city, String region, String url);

  Future<List<BannerResponse>> getBannerHome();

  Future<List<HomeCategoryResponse>> getHomeCategory();

  Future<List<NewsModelResponse>> getListNews();

  Future<List<HistoryModel>> getHistoryScanQrCode({required String deviceId});

  Future<NewsDetails> getNewsDetails({required int idNews});

  Future<ObjectResponse> requestOtp({required String phone});

  Future<ConfirmModel> comfirmOtp({required String phone, required String otp});

  Future<ObjectResponse> addDevice({required String deviceId});

  Future<IntroduceResponse> getSupportPolicy(String policyType);

  Future<ObjectResponse> saveProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
    required File? avatar,
  });

  Future<List<NotiModel>> getNotifications();

  Future<ObjectResponse> saveContact({
    String? productId,
    String? content,
    int? type,
  });
}
