import 'package:intl/intl.dart';
import 'package:qrcode/common/utils/log_util.dart';

class HistoryModel {
  int? id;
  dynamic userId;
  String? deviceId;
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

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    productId = json['product_id'];
    urlScan = json['url_scan'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
    image = json['featured_img'];
    // DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
    // DateFormat dateFormat1 = DateFormat('hh:mm dd/MM/yyyy');
    // if(updatedAt!=null){
    //  var dateTimeData = dateFormat.parse(updatedAt!);
    //  dateTime = dateFormat1.format(dateTimeData);
    // }
    if (updatedAt?.isNotEmpty ?? false) {
      DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
      DateTime dateTime = dateFormat.parse(updatedAt!);
      DateTime date2 = DateTime.fromMillisecondsSinceEpoch(
          dateTime.millisecondsSinceEpoch + 3600000 * 7);
      LOG.d('millisecondsSinceEpochNe: $date2');
      List<String>  ngayThang = date2.toString().substring(0,10).split('-').toList();
      String ngayThangText = ngayThang.reversed.join('/');
      String gio = date2.toString().substring(11,16);
      updatedAt = '$gio - $ngayThangText';
    }
  }

}