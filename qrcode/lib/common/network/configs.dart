import 'dart:io';

class Configurations {
  /// IMPORTANT - IMPORTANT - IMPORTANT
  /// xác định các API sẽ được chạy trên môi trường nào
  static const bool envProduct = false;

  /// set = true khi deploy (IMPORTANT)
  static const bool forDeploy = false;

  static String host = 'https://ketcausoft.com/api/v1/';

  static const String hostGoogleAddressApi =
      'https://maps.googleapis.com/maps/api/geocode/json?';

  /// remove this when clear data
  static const String hostImageOld = 'http://image.gstore.social/Originals/';

  static const String hostImage = 'http://image.gstore.social/Larges/';

  static const int connectTimeout = 30; // second
  static const double defaultSpaceNear = 25.0; // km
  static const int defaultSpaceNearInt = 25; // km
  static const int pageSize = 12;

  static String mapApiKey = 'AIzaSyDHlfJNIxSdG1bFyWIoUKqAU8P80krrKNw';

  /// điều khoản và chính sách

  // về gstore
  static const String urlPolicy =
      'https://sites.google.com/gstore.social/technicalcompany/trang-ch%E1%BB%A7?authuser=1';

  // về ký gửi hàng
  static const String depositPolicy =
      'https://sites.google.com/gstore.social/chinh-sach-ky-gui-hang-hoa/trang-ch%E1%BB%A7?authuser=4';

  // về mua hàng
  static const String buyPolicy =
      'https://sites.google.com/gstore.social/chinh-sach-mua-hang-gstore/trang-ch%E1%BB%A7?authuser=4';

  //Hướng dẫn đăng bán sản phẩm
  static const String huongDanDangBanSp =
      'https://sites.google.com/gstore.social/quy-dinh-dang-ban-san-pham/trang-ch%E1%BB%A7';

  /// chinh sách bán hàng trong landing
  static const String policySellLanding =
      'https://sites.google.com/gstore.social/chinh-sach-landing/trang-ch%E1%BB%A7';

  /// chinh sách mua hàng trong landing
  static const String policyBuyLanding =
      'https://sites.google.com/gstore.social/chnhschmuahngtronglanding/trang-ch%E1%BB%A7?authuser=4';

  static const String urlBoCongThuong =
      'http://online.gov.vn/Home/AppDetails/1318';
  static const String momoMerchantName = 'Tài Khoản G-STORE';
  static const String momoMerchantCode = 'MOMOYIQU20200912';
  static const String publishKeyMomo =
      'MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAia0gTDtLFKYrxGFHFMwz7/d6zok38mmdZQ72SgDDw0DF2+g3/g0V7Oz7mqDJkUBbfIR/6e9baCtdumh2YZs6PpJMnBz4p9yYYswZD+9gOkQhRFDTuOJ7RXT9AomDxwKcAaUIrX+/EpUdxyyJ6Dl2yO0DSlri/rDx2h84rrgcJbM3s8iiSeKxiDBioNa3+WBrc2Rx4mnNbP5uhFiQbzj6eAE1o5nDdFuWF29yX78gaRM1b7hMCdrit4CI02zOns3Ppjqs6RByOJNINNNVhpJ84K3/MhHkpf5M8V/pUur8BNEUMOhOjbuE+wdF2Il4yfxiGJxUb8mv+B2Phf3N81sPL9LzwV/3B9AKhLwSImbR0bGqMF2X0w+NMmrAfJZ3G9r4V7vTxBWQdc4UD0wUClSfKIVkNZxQDBazpSRBiB7Ba8mB3NhqLNhESfdAf5lQ2e94b9/WkvL5r3z/4Qe8VwbOIr8SNI7gVsEi8bl1xitGwXDsNN3Vhb75C+jI59SJlXR0XaLW8cmpwVO5k6KLcgUC7lCeSGmv6ZSQ+OOSh/n0jrZd3BwMWxe3O2cK+gWPV9tgPYJYysBe0PnWjYQpeFI9y967kB5lKzPgNBx7yNY1ssu5fYifkOFJa25BYIvOqhuK95LGE0sH4eyOIXDrqgXg78zEIhpa5y+WUOzPmf2V9VkCAwEAAQ==';

  static const double latGstore = 21.030235;
  static const double lngGstore = 105.761697;

  static const String versionAndroid = '1.0.14';

  static const String versionIos = '1.0.70';

  static const String urlAppStore =
      'https://apps.apple.com/us/app/id1537350489';
  static const String urlGooglePlay =
      'https://play.google.com/store/apps/details?id=com.company.gstore_app';

  static const String phoneCompany = '02473026899';
  static const int timeOutCall = 25;

  static const String packageId = 'com.company.gstore_app';
  static const String bundleId = 'com.gstore.social';
}
