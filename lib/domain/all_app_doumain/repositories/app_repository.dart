// Project imports:
part of app_layer;

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

  Future<NewsDetails> getNewsDetails({required int idNews});

  Future<ObjectResponse> requestOtp({required String phone});

  Future<ConfirmModel> comfirmOtp({required String phone, required String otp});

  Future<ObjectResponse> addDevice({required String deviceId});

  Future<IntroduceResponse> getSupportPolicy(String policyType);

  Future<ObjectResponse<ProfileModel>> saveProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
    required File? avatar,
  });

  Future<List<NotiModel>> getNotifications();

  Future<ObjectResponse> saveContact({
    String? productId,
    String? content,
    int? type,
  });

  Future<OrderCartsResponse> addToCart({
    int? productId,
  });

  Future<ObjectResponse<PaymentDebt>> payment({
    int? amount,
  });

  Future<ListCartsResponse> getListCart();
}
