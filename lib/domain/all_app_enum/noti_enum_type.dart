import 'package:json_annotation/json_annotation.dart';

enum PostTypeEnum {
  @JsonValue("notification")
  notification,
  @JsonValue("product")
  product,
  @JsonValue("order")
  order,
  @JsonValue("debts")
  debts,
  none
}
