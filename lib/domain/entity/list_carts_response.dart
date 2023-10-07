class ListCartsResponse {
  CartDataList? carts;

  ListCartsResponse({this.carts});

  ListCartsResponse.fromJson(Map<String, dynamic> json) {
    carts = json['carts'] != null ? CartDataList.fromJson(json['carts']) : null;
  }
}

class CartDataList {
  int? id;
  String? itemsCount;
  String? itemsQty;
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
  String? discountAmount;
  String? subtotalWithDiscount;
  String? subtotal;
  String? grandTotal;
  String? weight;
  String? createdAt;
  String? updatedAt;
  String? walletValue;
  dynamic tokenId;
  int? orderStatus;
  List<ItemsCarts>? items;

  CartDataList({
    this.id,
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
    this.orderStatus,
    this.items,
  });

  CartDataList.fromJson(Map<String, dynamic> json) {
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
    if (json['items'] != null) {
      items = <ItemsCarts>[];
      json['items'].forEach((v) {
        items!.add(ItemsCarts.fromJson(v));
      });
    }
  }

  double get getTotalOriginPrice =>
      items
          ?.map((e) => e.getTotalOriginPrice)
          .toList()
          .reduce((value, element) => value + element) ??
      0;

  double get getTotalPriceQty =>
      items
          ?.map((e) => e.getTotalPrice)
          .toList()
          .reduce((value, element) => value + element) ??
      0;

  int get getItemsQtyNum => double.parse(itemsQty ?? '0').toInt();

  double get getDisCountPrice => getTotalOriginPrice - getTotalPriceQty;
}

class ItemsCarts {
  int? id;
  int? quoteId;
  dynamic ruleIds;
  int? freeShipping;
  int? productId;
  dynamic additionalData;
  dynamic sku;
  dynamic productType;
  String? name;
  String? image;
  dynamic description;
  String? weight;
  String? qty;
  String? originPrice;
  String? salePrice;
  String? customPrice;
  String? discountPercent;
  String? discountAmount;
  String? taxPercent;
  String? taxAmount;
  String? rowTotalWithDiscount;
  String? rowTotal;
  String? rowWeight;
  String? rowTotalWithTax;
  int? status;
  String? createdAt;
  String? updatedAt;

  ItemsCarts({
    this.id,
    this.quoteId,
    this.ruleIds,
    this.freeShipping,
    this.productId,
    this.additionalData,
    this.sku,
    this.productType,
    this.name,
    this.image,
    this.description,
    this.weight,
    this.qty,
    this.originPrice,
    this.salePrice,
    this.customPrice,
    this.discountPercent,
    this.discountAmount,
    this.taxPercent,
    this.taxAmount,
    this.rowTotalWithDiscount,
    this.rowTotal,
    this.rowWeight,
    this.rowTotalWithTax,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ItemsCarts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteId = json['quote_id'];
    ruleIds = json['rule_ids'];
    freeShipping = json['free_shipping'];
    productId = json['product_id'];
    additionalData = json['additional_data'];
    sku = json['sku'];
    productType = json['product_type'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    weight = json['weight'];
    qty = json['qty'];
    originPrice = json['origin_price'];
    salePrice = json['sale_price'];
    customPrice = json['custom_price'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    taxPercent = json['tax_percent'];
    taxAmount = json['tax_amount'];
    rowTotalWithDiscount = json['row_total_with_discount'];
    rowTotal = json['row_total'];
    rowWeight = json['row_weight'];
    rowTotalWithTax = json['row_total_with_tax'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  double get getSalePrice => double.parse(salePrice ?? '0');

  double get getOriginPrice => double.parse(originPrice ?? '0');

  double get getTotalPrice => getSalePrice * getQtyNum;

  double get getTotalOriginPrice => getOriginPrice * getQtyNum;

  int get getQtyNum => double.parse(qty ?? '0').toInt();
}
