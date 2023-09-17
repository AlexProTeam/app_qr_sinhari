import 'package:dio/dio.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../common/model/banner_model.dart';
import '../../../common/response/home_response.dart';
import '../../../domain/entity/profile_model.dart';
import '../../../presentation/auth/welcome/welcome_model.dart';
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
  Future<ProfileModel> getShowProfile();

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
}
