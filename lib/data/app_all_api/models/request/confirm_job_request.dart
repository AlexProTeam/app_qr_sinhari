import 'package:json_annotation/json_annotation.dart';

part 'confirm_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ConfirmCartRequest {
  @JsonKey(name: 'product_ids')
  List<int> confirmJobs;
  @JsonKey(name: 'address_id')
  int addressId;

  ConfirmCartRequest({
    required this.confirmJobs,
    required this.addressId,
  });

  factory ConfirmCartRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmCartRequestToJson(this);
}
