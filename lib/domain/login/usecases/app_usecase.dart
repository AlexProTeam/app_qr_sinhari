// Project imports:

import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_model.dart';

import '../../../data/app_all_api/models/request/login_request.dart';
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

  Future<Data> getListFeature() => _repository.getListFeature();

  Future<Data> getListSeller() => _repository.getListSeller();

  Future<DataDetail> getDetaiProduct(int productId) =>
      _repository.getDetaiProduct(productId);

  Future<DataDetail> getDetaiProductByQr(
          String deviceId, String city, String region, String url) =>
      _repository.getDetaiProductByQr(deviceId, city, region, url);
}
