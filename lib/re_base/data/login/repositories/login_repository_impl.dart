// Project imports:

import '../../../domain/login/repositories/login_repository.dart';
import '../api/login_api.dart';
import '../models/request/login_request.dart';
import '../models/response/login_response.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi api;

  LoginRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // await api
    //     .login(request)
    //     .catchError((e, stack) => throw ApiException.error(e, stack));
    await Future.delayed(const Duration(seconds: 3));

    return const LoginResponse(
      userName: "UserName",
      userPhone: "phone",
      email: "email",
    );
  }
}
