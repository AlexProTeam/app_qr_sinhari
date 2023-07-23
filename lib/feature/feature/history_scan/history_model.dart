import 'package:intl/intl.dart';

class HistoryModel {
  int? id;
  dynamic userId;
  // String? deviceId;
  int? productId;
  String? urlScan;
  String? city;
  String? region;
  dynamic country;
  String? createdAt;
  String? updatedAt;
  String? productName;
  String? dateTime;
  String? image;
  String? code;
  String? numberSeri;
  String? count;

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    // deviceId = json['device_id'];
    productId = json['product_id'];
    urlScan = json['url_scan'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
    image = json['featured_img'];
    code = json['serial_code'];
    numberSeri = json['serial_id'];
    count = json['count'];
    if (updatedAt?.isNotEmpty ?? false) {
      DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
      DateTime dateTime = dateFormat.parse(updatedAt!);
      DateTime date2 = DateTime.fromMillisecondsSinceEpoch(
          dateTime.millisecondsSinceEpoch + 3600000 * 7);
      List<String> ngayThang =
          date2.toString().substring(0, 10).split('-').toList();
      String ngayThangText = ngayThang.reversed.join('/');
      String gio = date2.toString().substring(11, 16);
      updatedAt = '$gio - $ngayThangText';
    }
  }
}
