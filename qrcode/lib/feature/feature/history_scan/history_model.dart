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
  }

}