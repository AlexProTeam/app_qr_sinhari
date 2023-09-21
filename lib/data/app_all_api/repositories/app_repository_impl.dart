// Project imports:

part of app_layer;

class AppRepositoryImpl implements AppRepository {
  final AppApi api;

  AppRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    await api
        .login(request)
        .catchError((e, stack) => throw ApiException.error(e, stack));
    await Future.delayed(const Duration(seconds: 3));

    return const LoginResponse(
      userName: "UserName",
      userPhone: "phone",
      email: "email",
    );
  }

  @override
  Future<ProfileModel> getShowProfile() async {
    try {
      final response = await api.getShowProfile();

      return response.data ?? ProfileModel();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<WelcomeModel> getImageIntroduction() async {
    try {
      final response = await api.getImageIntroduction();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataProduct> getListFeature() async {
    try {
      final response = await api.getListFeature();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataProduct> getListSeller() async {
    try {
      final response = await api.getListSeller();

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DataDetail> getDetaiProduct(int productId) async {
    try {
      final response = await api.getDetaiProduct(productId);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<DetailByQr> getDetaiProductByQr(
      String deviceId, String city, String region, String url) async {
    try {
      final response =
          await api.getDetaiProductByQr(deviceId, city, region, url);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<BannerResponse>> getBannerHome() async {
    try {
      final response = await api.getBannerHome();

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<HomeCategoryResponse>> getHomeCategory() async {
    try {
      final response = await api.getHomeCategory();

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<NewsModelResponse>> getListNews() async {
    try {
      final response = await api.getListNews();

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<HistoryModel>> getHistoryScanQrCode(
      {required String deviceId}) async {
    try {
      final response = await api.getHistoryScanQrCode(deviceId);

      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<NewsDetails> getNewsDetails({required int idNews}) async {
    try {
      final response = await api.getDetailsNews(idNews);
      return response.data ?? NewsDetails();
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> requestOtp({required String phone}) async {
    try {
      final response = await api.requestOtp(phone);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ConfirmModel> comfirmOtp(
      {required String phone, required String otp}) async {
    try {
      final response = await api.comfirmOtp(phone, otp);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> addDevice({
    required String deviceId,
  }) async {
    try {
      final response = await api.addDevice(deviceId);

      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<IntroduceResponse> getSupportPolicy(String policyType) async {
    try {
      final response = await api.policy(policyType);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> saveProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
    required File? avatar,
  }) async {
    try {
      final response =
          await api.saveProfile(name, email, phone, address, avatar);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<List<NotiModel>> getNotifications() async {
    try {
      final response = await api.getNotifications();
      return response.data ?? [];
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }

  @override
  Future<ObjectResponse> saveContact({
    String? productId,
    String? content,
    int? type,
  }) async {
    try {
      final response = await api.saveContact(productId, content, type);
      return response;
    } on DioException catch (e) {
      throw (ApiException.error(e));
    }
  }
}
