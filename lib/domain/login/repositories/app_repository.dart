// Project imports:

import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';

import '../../../common/model/banner_model.dart';
import '../../../common/response/home_response.dart';
import '../../../data/app_all_api/models/request/login_request.dart';
import '../../../data/app_all_api/models/response/login_response.dart';
import '../../../presentation/auth/welcome/welcome_model.dart';
import '../../../presentation/feature/history_scan/history_model.dart';
import '../../../presentation/feature/news/history_model.dart';
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
}
