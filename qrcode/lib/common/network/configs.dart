import 'dart:io';

class Configurations {
  /// IMPORTANT - IMPORTANT - IMPORTANT
  /// xác định các API sẽ được chạy trên môi trường nào
  static const bool envProduct = false;

  /// set = true khi deploy (IMPORTANT)
  static const bool forDeploy = false;

  static String host = 'https://admin.sinhairvietnam.vn/api/';

  static const int connectTimeout = 30; // second
  static const int pageSize = 12;
}
