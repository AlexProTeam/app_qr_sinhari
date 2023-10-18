import 'package:json_annotation/json_annotation.dart';

part 'object_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class ObjectResponse<T> {
  final T? data;
  final bool? success;
  final String? message;
  final int? status;
  final T? notifications;

  factory ObjectResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ObjectResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ObjectResponseToJson(this, toJsonT);

  const ObjectResponse({
    this.success,
    this.message,
    this.data,
    this.status,
    this.notifications,
  });
}
