import 'package:dio/dio.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/entity/profile_model.dart';
import '../../../presentation/auth/welcome/welcome_model.dart';
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
  Future<ProfileModel> getShowProfile();

  @POST('get_image_introduction')
  Future<WelcomeModel> getImageIntroduction();

  @GET('product-feature?page=1')
  Future<Data> getListFeature();

  @GET('product-seller?page=1')
  Future<Data> getListSeller();

  @GET('scan-qr-code')
  Future<DetailByQr> getDetaiProductByQr(
      @Query('device_id') String deviceId,
      @Query('city') String city,
      @Query('region') String region,
      @Query('url') String url);

  @GET('products/show/{productId}')
  Future<DataDetail> getDetaiProduct(@Path("productId") int productId);
}
