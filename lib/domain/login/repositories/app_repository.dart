// Project imports:

import '../../../data/app_all_api/models/request/login_request.dart';
import '../../../data/app_all_api/models/response/login_response.dart';
import '../../../presentation/auth/welcome/welcome_model.dart';
import '../../entity/profile_model.dart';

abstract class AppRepository {
  Future<LoginResponse> login(LoginRequest request);

  Future<ProfileModel> getShowProfile();

  Future<WelcomeModel> getImageIntroduction();
}
