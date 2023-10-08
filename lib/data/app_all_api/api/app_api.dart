import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qrcode/domain/entity/add_to_cart_model.dart';
import 'package:qrcode/domain/entity/confirm_model.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/domain/entity/details_news_model.dart';
import 'package:qrcode/domain/entity/home_response.dart';
import 'package:qrcode/domain/entity/introduce_model.dart';
import 'package:qrcode/domain/entity/noti_model.dart';
import 'package:qrcode/domain/entity/order_model.dart';
import 'package:qrcode/domain/entity/payment_debt_model.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/domain/entity/welcome_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/entity/banner_model.dart';
import '../../../domain/entity/list_carts_response.dart';
import '../../../domain/entity/profile_model.dart';
import '../../../presentation/feature/history_scan/history_model.dart';
import '../../../presentation/feature/news/history_model.dart';
import '../../responses/object_response.dart';
import '../models/request/login_request.dart';
import '../models/response/login_response.dart';

// Project imports:

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST('/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @GET('auth/showProfile')
  Future<ObjectResponse<ProfileModel>> getShowProfile();

  @POST('get_image_introduction')
  Future<WelcomeModel> getImageIntroduction();

  @GET('product-feature?page=1')
  Future<DataProduct> getListFeature();

  @GET('product-seller?page=1')
  Future<DataProduct> getListSeller();

  @GET('scan-qr-code')
  Future<DetailByQr> getDetaiProductByQr(
    @Query('device_id') String deviceId,
    @Query('city') String city,
    @Query('region') String region,
    @Query('url') String url,
  );

  @GET('products/show/{productId}')
  Future<DataDetail> getDetaiProduct(@Path("productId") int productId);

  @GET('banners')
  Future<ObjectResponse<List<BannerResponse>>> getBannerHome();

  @POST('get_home_category')
  Future<ObjectResponse<List<HomeCategoryResponse>>> getHomeCategory();

  @POST('list_news')
  Future<ObjectResponse<List<NewsModelResponse>>> getListNews();

  @GET('history-scan-qr-code')
  Future<ObjectResponse<List<HistoryModel>>> getHistoryScanQrCode(
    @Query('device_id') String? deviceId,
  );

  @POST('news_detail')
  Future<ObjectResponse<NewsDetails>> getDetailsNews(
    @Part(name: 'news_id') int? idNews,
  );

  @POST('auth-with-otp?phone=')
  Future<ObjectResponse> requestOtp(
    @Part(name: "phone") String phone,
  );

  @POST('confirm-otp')
  Future<ConfirmModel> comfirmOtp(
    @Part(name: "phone") String phone,
    @Part(name: "otp") String otp,
  );

  @POST('add_device')
  Future<ObjectResponse> addDevice(
    @Part(name: "device_id") String deviceId,
  );

  @POST('policy')
  Future<IntroduceResponse> policy(
    @Query('type') String? typePolicy,
  );

  @POST('auth/saveProfile')
  Future<ObjectResponse<ProfileModel>> saveProfile(
    @Query('name') String? name,
    @Query('email') String? email,
    @Query('phone') String? phone,
    @Query('address') String? address,
    @Path() File? avatar,
  );

  @POST('notifications')
  Future<ObjectResponse<List<NotiModel>>> getNotifications();

  @POST('save-contact')
  Future<ObjectResponse> saveContact(
    @Query('product_id') String? productId,
    @Query('content') String? content,
    @Query('type') int? type,
  );

  @POST('add_to_cart')
  Future<ObjectResponse<OrderCartsResponse>> addToCart(
    @Part(name: "product_id") int productId,
  );

  @POST('payment_debt')
  Future<ObjectResponse<PaymentDebt>> postPayment(
    @Query('amount') int amount,
  );

  @POST('get_to_cart')
  Future<ObjectResponse<ListCartsResponse>> getListCart();

  @POST('product_agency')
  Future<DataProduct> getListAngecy();

  @POST('orders')
  Future<OrderModel> getListOrder(
      @Part(name: 'status_order') String? statusOrder);

  @POST('add_quantity')
  Future<ObjectResponse<ListCartsResponse>> postQuality(
    @Query('product_id') int productId,
    @Query('qty') int qty,
  );

  @POST('order_cart')
  Future<ObjectResponse> postConfirmCart();
}
