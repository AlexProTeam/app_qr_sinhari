// Project imports:
part of app_layer;

class AppConstant {
  static const Duration connectionTimeOutApp = Duration(seconds: 30);

  static const String someThingWentWrong = 'Lỗi không xác định';
  static const String copiedToClipboard = 'Đã copy vào bộ nhớ tạm';
  static const String connectError = 'Vui lòng kiểm tra internet của bạn';

  static List<BoxShadow> defaultShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 3,
        blurRadius: 5,
        offset: const Offset(0, 4))
  ];

  static const String contentCamera =
      'Cho phép chúng tôi truy cập quyền này sẽ giúp cho bạn chọn được ảnh';
  static const String titlePhoto =
      'Bạn có cho phép GStore truy cập vào bộ sưu tập ảnh của bạn không?';
  static const String allow = 'Cho phép';
  static const String notAllow = 'Không cho phép';
}
