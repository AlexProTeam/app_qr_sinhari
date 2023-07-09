import 'package:qrcode/common/model/profile_model.dart';

///todo: convert to save in bloc
class AppCache {
  ProfileModel? profileModel;
  bool havedLogin = false;
  int? cacheProductId;
  String? cacheDataProduct;
  String? deviceId;
}
