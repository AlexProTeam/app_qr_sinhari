// Project imports:
part of app_layer;

class AppConstant {
  static const Duration connectionTimeOutApp = Duration(seconds: 30);

  static List<BoxShadow> defaultShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 3,
        blurRadius: 5,
        offset: const Offset(0, 4))
  ];

  static const String contentCamera =
      'Cho phép chúng tôi truy cập quyền này sẽ giúp cho bạn chọn được ảnh';

  static const String allow = 'Cho phép';
  static const String notAllow = 'Không cho phép';
  static const int timerPaymentReload = 120;

  static const String portBackgroundMessage = 'SINHAIR_APP_BACKGROUND_MESSAGE';
}
