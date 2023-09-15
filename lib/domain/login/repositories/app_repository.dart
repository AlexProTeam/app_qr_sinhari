// Project imports:

import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';

import '../../../data/app_all_api/models/request/login_request.dart';
import '../../../data/app_all_api/models/response/login_response.dart';
import '../../../presentation/auth/welcome/welcome_model.dart';
import '../../entity/profile_model.dart';

abstract class AppRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<ProfileModel> getShowProfile();

  Future<WelcomeModel> getImageIntroduction();

  Future<Data> getListFeature();

  Future<Data> getListSeller();

  Future<DataDetail> getDetaiProduct(int productId);

  Future<DataDetail> getDetaiProductByQr(
      String deviceId, String city, String region, String url);
}
