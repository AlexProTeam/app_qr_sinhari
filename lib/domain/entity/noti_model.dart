import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotiResponse {
  int? id;
  String? title;
  String? des;
  String? content;
  String? image;
  String? imageThumbs;
  String? createdAt;

  NotiResponse(
    this.id,
    this.title,
    this.des,
    this.content,
    this.image,
    this.imageThumbs,
    this.createdAt,
  );

  NotiResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    des = json['description'];
    content = json['content'];
    image = json['image'];
    imageThumbs = json['image_thumbs'];
    createdAt = json['created_at'];
    if (createdAt?.isNotEmpty ?? false) {
      DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
      DateTime dateTime = dateFormat.parse(createdAt!);
      DateTime date2 = DateTime.fromMillisecondsSinceEpoch(
          dateTime.millisecondsSinceEpoch + 3600000 * 7);

      createdAt = timeago.format(date2);
    }
  }
}
