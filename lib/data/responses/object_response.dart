import 'package:json_annotation/json_annotation.dart';

part 'object_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class ObjectResponse<T> {
  final T? result;
  final bool? success;
  final String? message;
  final int? status;

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
    this.result,
    this.status,
  });
}
