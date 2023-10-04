class AddToCartModel {
  bool? error;
  Data? data;
  String? message;
  bool? success;

  AddToCartModel({this.error, this.data, this.message, this.success});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }
}

class Data {
  Carts? carts;

  Data({this.carts});

  Data.fromJson(Map<String, dynamic> json) {
    carts = json['carts'] != null ? Carts.fromJson(json['carts']) : null;
  }
}

class Carts {
  int? id;
  int? itemsCount;
  int? itemsQty;
  String? currencyCode;
  dynamic checkoutMethod;
  int? customerId;
  int? customerGroupId;
  dynamic customerFirstname;
  dynamic customerLastname;
  dynamic customerEmail;
  dynamic customerNote;
  dynamic customerNoteNotify;
  int? customerIsGuest;
  dynamic remoteIp;
  dynamic ruleIds;
  dynamic reservedOrderId;
  dynamic couponCode;
  int? discountAmount;
  String? subtotalWithDiscount;
  int? subtotal;
  int? grandTotal;
  int? weight;
  String? createdAt;
  String? updatedAt;
  String? walletValue;
  dynamic tokenId;
  int? orderStatus;

  Carts(
      {this.id,
      this.itemsCount,
      this.itemsQty,
      this.currencyCode,
      this.checkoutMethod,
      this.customerId,
      this.customerGroupId,
      this.customerFirstname,
      this.customerLastname,
      this.customerEmail,
      this.customerNote,
      this.customerNoteNotify,
      this.customerIsGuest,
      this.remoteIp,
      this.ruleIds,
      this.reservedOrderId,
      this.couponCode,
      this.discountAmount,
      this.subtotalWithDiscount,
      this.subtotal,
      this.grandTotal,
      this.weight,
      this.createdAt,
      this.updatedAt,
      this.walletValue,
      this.tokenId,
      this.orderStatus});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    currencyCode = json['currency_code'];
    checkoutMethod = json['checkout_method'];
    customerId = json['customer_id'];
    customerGroupId = json['customer_group_id'];
    customerFirstname = json['customer_firstname'];
    customerLastname = json['customer_lastname'];
    customerEmail = json['customer_email'];
    customerNote = json['customer_note'];
    customerNoteNotify = json['customer_note_notify'];
    customerIsGuest = json['customer_is_guest'];
    remoteIp = json['remote_ip'];
    ruleIds = json['rule_ids'];
    reservedOrderId = json['reserved_order_id'];
    couponCode = json['coupon_code'];
    discountAmount = json['discount_amount'];
    subtotalWithDiscount = json['subtotal_with_discount'];
    subtotal = json['subtotal'];
    grandTotal = json['grand_total'];
    weight = json['weight'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    walletValue = json['wallet_value'];
    tokenId = json['token_id'];
    orderStatus = json['order_status'];
  }
}
