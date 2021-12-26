import 'package:intl/intl.dart';

class NewsDetailModel {
  int? id;
  String? title;
  String? categoryNew;
  String? content;
  String? userId;
  String? description;
  String? image;
  String? imageThumbs;
  String? createdAt;

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryNew = json['category_news_id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    image = json['image'];
    imageThumbs = json['image_thumbs'];
    createdAt = json['created_at'];
    if (createdAt?.isNotEmpty ?? false) {
      DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
      DateTime dateTime = dateFormat.parse(createdAt!);
      DateTime date2 = DateTime.fromMillisecondsSinceEpoch(
          dateTime.millisecondsSinceEpoch + 3600000 * 7);
      // LOG.d('millisecondsSinceEpochNe: $date2');
      List<String> ngayThang =
          date2.toString().substring(0, 10).split('-').toList();
      String ngayThangText = ngayThang.reversed.join('/');
      String gio = date2.toString().substring(11, 16);
      createdAt = '$gio - $ngayThangText';
    }
  }
}
