// Project imports:

import '../../../data/login/models/request/login_request.dart';
import '../entities/user_entitiy.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<UserEntity> login(LoginRequest request) => _repository.login(request);
}
