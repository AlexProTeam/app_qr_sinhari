// Project imports:

import 'package:qrcode/common/model/confirm_model.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/details_news_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/data/responses/object_response.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_model.dart';

import '../../../common/model/Introduce_model.dart';
import '../../../common/model/banner_model.dart';
import '../../../common/response/home_response.dart';
import '../../../data/app_all_api/models/request/login_request.dart';
import '../../../presentation/feature/history_scan/history_model.dart';
import '../../../presentation/feature/news/history_model.dart';
import '../../entity/profile_model.dart';
import '../entities/user_entitiy.dart';
import '../repositories/app_repository.dart';

class AppUseCase {
  final AppRepository _repository;

  AppUseCase(this._repository);

  Future<UserEntity> login(LoginRequest request) => _repository.login(request);

  Future<ProfileModel> getShowProfile() => _repository.getShowProfile();

  Future<WelcomeModel> getImageIntroduction() =>
      _repository.getImageIntroduction();

  Future<DataProduct> getListFeature() => _repository.getListFeature();

  Future<DataProduct> getListSeller() => _repository.getListSeller();

  Future<DataDetail> getDetaiProduct(int productId) =>
      _repository.getDetaiProduct(productId);

  Future<DetailByQr> getDetaiProductByQr(
    String deviceId,
    String city,
    String region,
    String url,
  ) =>
      _repository.getDetaiProductByQr(
        deviceId,
        city,
        region,
        url,
      );

  Future<List<BannerResponse>> getBannerHome() => _repository.getBannerHome();

  Future<List<HomeCategoryResponse>> getHomeCategory() =>
      _repository.getHomeCategory();

  Future<List<NewsModelResponse>> getListNews() => _repository.getListNews();

  Future<List<HistoryModel>> getHistoryScanQrCode(String deviceId) =>
      _repository.getHistoryScanQrCode(deviceId: deviceId);

  Future<NewsDetails> getNewsDetails(int idNews) =>
      _repository.getNewsDetails(idNews: idNews);

  Future<ObjectResponse> requestOtp(String phone) =>
      _repository.requestOtp(phone: phone);

  Future<ConfirmModel> comfirmOtp(String phone, String otp) =>
      _repository.comfirmOtp(phone: phone, otp: otp);

  Future<ObjectResponse> addDevice(String deviceId) =>
      _repository.addDevice(deviceId: deviceId);

  Future<Introduce> getSupportPolicy(String policyType) =>
      _repository.getSupportPolicy(policyType);
}
