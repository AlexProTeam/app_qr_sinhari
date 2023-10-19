// Project imports:
part of app_layer;

class AppUseCase {
  final AppRepository _repository;

  AppUseCase(this._repository);

  Future<UserEntity> login(LoginRequest request) => _repository.login(request);

  Future<ProfileModel> getShowProfile() => _repository.getShowProfile();

  Future<WelcomeModel> getImageIntroduction() =>
      _repository.getImageIntroduction();

  Future<DataProduct> getListFeature() => _repository.getListFeature();

  Future<DataProduct> getListSeller() => _repository.getListSeller();

  Future<DataDetail> getDetaiProduct(int productId) =>
      _repository.getDetaiProduct(productId);

  Future<DetailByQr> getDetaiProductByQr(
    String deviceId,
    String city,
    String region,
    String url,
  ) =>
      _repository.getDetaiProductByQr(
        deviceId,
        city,
        region,
        url,
      );

  Future<List<BannerResponse>> getBannerHome() => _repository.getBannerHome();

  Future<List<HomeCategoryResponse>> getHomeCategory() =>
      _repository.getHomeCategory();

  Future<List<NewsModelResponse>> getListNews() => _repository.getListNews();

  Future<List<HistoryModel>> getHistoryScanQrCode(String deviceId) =>
      _repository.getHistoryScanQrCode(deviceId: deviceId);

  Future<NewsDetails> getNewsDetails(int idNews) =>
      _repository.getNewsDetails(idNews: idNews);

  Future<ObjectResponse> requestOtp(String phone) =>
      _repository.requestOtp(phone: phone);

  Future<ConfirmModel> comfirmOtp(
    String phone,
    String otp,
    String deviceId,
  ) =>
      _repository.comfirmOtp(
        phone: phone,
        otp: otp,
        deviceId: deviceId,
      );

  Future<ObjectResponse> addDevice(String deviceId) =>
      _repository.addDevice(deviceId: deviceId);

  Future<IntroduceResponse> getSupportPolicy(String policyType) =>
      _repository.getSupportPolicy(policyType);

  Future<ObjectResponse<ProfileModel>> saveProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
  }) =>
      _repository.saveProfile(
        name: name,
        email: email,
        phone: phone,
        address: address,
      );

  Future<ObjectResponse<ProfileModel>> saveProfileAvatar({
    required String? name,
    required String? email,
    required String? phone,
    required String? address,
    required File avatar,
  }) =>
      _repository.saveProfileAvatar(
        name: name,
        email: email,
        phone: phone,
        address: address,
        avatar: avatar,
      );

  Future<List<NotiResponse>> getNotifications() =>
      _repository.getNotifications();

  Future<ObjectResponse> saveContact({
    String? productId,
    String? content,
    int? type,
  }) =>
      _repository.saveContact(
        content: content,
        productId: productId,
        type: type,
      );

  Future<OrderCartsResponse> addToCart({
    int? productId,
  }) =>
      _repository.addToCart(productId: productId);

  Future<ObjectResponse<PaymentDebt>> payMent({
    int? amount,
  }) =>
      _repository.payment(amount: amount);

  Future<OrderCartsResponse> postQuality({
    int? productId,
    int? qty,
  }) =>
      _repository.changeQuality(
        productId: productId,
        qty: qty,
      );

  Future<ConfirmCartResponse> postConfirmCart(List<int> productIds) =>
      _repository.confirmCart(ConfirmCartRequest(confirmJobs: productIds));

  Future<ListCartsResponse> getListCart({
    int? productId,
  }) =>
      _repository.getListCart();

  Future<DataProduct> getListAngecy() => _repository.getListAngecy();

  Future<DataListOrder> getListOrder({String? statusOrder}) =>
      _repository.getListOrder(statusOrder: statusOrder);

  Future<ObjectResponse> deleteItemCart({
    required int id,
  }) =>
      _repository.deleteItemCart(id);

  Future<ObjectResponse<DataOrderDetail>> getDetailOrder({
    int? proId,
  }) =>
      _repository.getDetailOrder(proId);

  Future<HistoryDebtResponse> getListDebt() => _repository.getListDebt();

  Future<ObjectResponse> paymentConfirm() => _repository.paymentConfirm();
}
