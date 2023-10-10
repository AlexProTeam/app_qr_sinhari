class ConfirmCartResponse {
  ConfirmOrderDetail? orderDetail;

  ConfirmCartResponse({this.orderDetail});

  ConfirmCartResponse.fromJson(Map<String, dynamic> json) {
    orderDetail = json['order_detail'] != null
        ? ConfirmOrderDetail.fromJson(json['order_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetail != null) {
      data['order_detail'] = orderDetail!.toJson();
    }
    return data;
  }
}

class ConfirmOrderDetail {
  int? userId;
  Status? status;
  int? amount;
  int? subTotal;
  String? description;
  String? code;
  String? updatedAt;
  String? createdAt;
  int? id;

  ConfirmOrderDetail(
      {this.userId,
      this.status,
      this.amount,
      this.subTotal,
      this.description,
      this.code,
      this.updatedAt,
      this.createdAt,
      this.id});

  ConfirmOrderDetail.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    amount = json['amount'];
    subTotal = json['sub_total'];
    description = json['description'];
    code = json['code'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['amount'] = amount;
    data['sub_total'] = subTotal;
    data['description'] = description;
    data['code'] = code;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class Status {
  String? value;
  String? label;

  Status({this.value, this.label});

  Status.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    return data;
  }
}
