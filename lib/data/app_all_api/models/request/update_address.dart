import 'package:json_annotation/json_annotation.dart';

part 'update_address.g.dart';

@JsonSerializable(includeIfNull: false)
class CUAddressRequest {
  @JsonKey(name: 'address_id')
  final int? addressId;
  final String? name;
  final String? phone;
  final String? address;
  final int? isDefault;
  @JsonKey(name: 'customer_id')
  final int? customerId;
  final String? note;

  const CUAddressRequest({
    this.name,
    this.phone,
    this.address,
    this.isDefault,
    this.customerId,
    this.note,
    this.addressId,
  });

  factory CUAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$CUAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CUAddressRequestToJson(this);
}
