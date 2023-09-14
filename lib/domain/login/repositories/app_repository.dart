// Project imports:

import '../../../data/login/models/request/login_request.dart';
import '../../../data/login/models/response/login_response.dart';
import '../../entity/profile_model.dart';

abstract class AppRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<ProfileModel> getShowProfile();
}
