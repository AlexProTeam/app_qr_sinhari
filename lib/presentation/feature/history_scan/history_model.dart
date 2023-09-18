import 'package:intl/intl.dart';

class HistoryModel {
  int? id;
  dynamic userId;
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

  HistoryModel({
    this.id,
    this.userId,
    this.productId,
    this.urlScan,
    this.city,
    this.region,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.dateTime,
    this.image,
    this.code,
    this.numberSeri,
    this.count,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      urlScan: json['url_scan'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      createdAt: json['created_at'],
      updatedAt: _formatUpdatedAt(json['updated_at']),
      productName: json['product_name'],
      image: json['featured_img'],
      code: json['serial_code'],
      numberSeri: json['serial_id'],
      count: json['count'],
    );
  }

  static String _formatUpdatedAt(String? updatedAt) {
    if (updatedAt?.isNotEmpty != true) return updatedAt ?? '';

    final dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
    final dateTime = dateFormat.parse(updatedAt!);
    final updatedDateTime = dateTime.add(const Duration(hours: 7));

    final ngayThang = DateFormat('dd/MM/yyyy').format(updatedDateTime);
    final gio = DateFormat('HH:mm').format(updatedDateTime);

    return '$gio - $ngayThang';
  }
}
