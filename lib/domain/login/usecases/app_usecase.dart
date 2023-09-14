// Project imports:

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
}
