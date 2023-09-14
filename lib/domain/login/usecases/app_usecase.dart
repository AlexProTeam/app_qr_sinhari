// Project imports:

import '../../../data/login/models/request/login_request.dart';
import '../../entity/profile_model.dart';
import '../entities/user_entitiy.dart';
import '../repositories/app_repository.dart';

class AppUseCase {
  final AppRepository _repository;

  AppUseCase(this._repository);

  Future<UserEntity> login(LoginRequest request) => _repository.login(request);

  Future<ProfileModel> getShowProfile() => _repository.getShowProfile();
}
