import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../all_app_enum/noti_enum_type.dart';

part 'noti_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotiResponse {
  @JsonKey(name: 'id')
  int? id;
  String? title;
  @JsonKey(name: 'description')
  String? des;
  String? content;
  String? image;
  @JsonKey(name: 'image_thumbs')
  String? imageThumbs;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'post_type')
  PostTypeEnum? postType;
  @JsonKey(name: 'order_id')
  int? orderId;
  @JsonKey(name: 'product_id')
  int? productId;

  NotiResponse(
    this.id,
    this.title,
    this.des,
    this.content,
    this.image,
    this.imageThumbs,
    this.createdAt,
    this.postType,
    this.orderId,
    this.productId,
  );

  factory NotiResponse.fromJson(Map<String, dynamic> json) =>
      _$NotiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotiResponseToJson(this);

  String get getCreatedAt {
    if (createdAt?.isEmpty == true) {
      return '';
    }

    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    DateTime dateTime = dateFormat.parse(createdAt!);
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch + 3600000 * 7);

    return timeago.format(date2);
  }
}
