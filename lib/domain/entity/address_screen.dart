class AddressResponse {
  int? id;
  String? name;
  String? phone;
  String? address;
  int? isDefault;
  int? customerId;
  String? note;

  AddressResponse({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.isDefault,
    this.customerId,
    this.note,
  });

  bool get getIsDefault => isDefault == 1;

  AddressResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    isDefault = json['is_default'];
    customerId = json['customer_id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['is_default'] = isDefault;
    data['customer_id'] = customerId;
    data['note'] = note;
    return data;
  }
}
