import 'package:json_annotation/json_annotation.dart';

part 'confirm_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ConfirmCartRequest {
  @JsonKey(name: 'product_ids')
  List<int> confirmJobs;

  ConfirmCartRequest({required this.confirmJobs});

  factory ConfirmCartRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmCartRequestToJson(this);
}
