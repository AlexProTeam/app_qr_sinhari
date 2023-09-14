import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/page_entity.dart';

part 'array_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class ArrayResponse<T> {
  final PageResponse<T>? result;
  final bool? success;
  final String? message;
  final int? statusCode;

  factory ArrayResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ArrayResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ArrayResponseToJson(this, toJsonT);

  const ArrayResponse({
    this.success,
    this.message,
    this.result,
    this.statusCode,
  });
}

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class PageResponse<T> extends PageEntity<T> {
  @override
  // ignore: overridden_fields
  final List<T> items;
  @override
  // ignore: overridden_fields
  final int? total;
  @override
  // ignore: overridden_fields
  final int? statusCode;

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PageResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageResponseToJson(this, toJsonT);

  PageResponse({
    required this.items,
    this.total,
    this.statusCode,
  }) : super(items: []);
}
