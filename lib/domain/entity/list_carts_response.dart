class ListCartsResponse {
  CartDataList? carts;

  ListCartsResponse({this.carts});

  ListCartsResponse.fromJson(Map<String, dynamic> json) {
    carts = json['carts'] != null ? CartDataList.fromJson(json['carts']) : null;
  }

  ListCartsResponse copyWith({
    CartDataList? carts,
  }) {
    return ListCartsResponse(
      carts: carts ?? this.carts,
    );
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

  double get getTotalOriginPrice {
    if (items != null && items!.isNotEmpty) {
      return items!
          .map((e) => e.getTotalOriginPrice)
          .toList()
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  double get getTotalPriceQty {
    if (items != null && items!.isNotEmpty) {
      return items!
          .map((e) => e.getTotalPrice)
          .toList()
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  int? get calQtyProduct {
    if (items != null && items!.isNotEmpty) {
      return items!
          .map((e) => e.getQtyNum)
          .toList()
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  int get getItemsQtyNum =>
      calQtyProduct ?? double.parse(itemsQty ?? '0').toInt();

  double get getDisCountPrice => getTotalOriginPrice - getTotalPriceQty;

  CartDataList copyWith({
    int? id,
    String? itemsCount,
    String? itemsQty,
    String? currencyCode,
    dynamic checkoutMethod,
    int? customerId,
    int? customerGroupId,
    dynamic customerFirstname,
    dynamic customerLastname,
    dynamic customerEmail,
    dynamic customerNote,
    dynamic customerNoteNotify,
    int? customerIsGuest,
    dynamic remoteIp,
    dynamic ruleIds,
    dynamic reservedOrderId,
    dynamic couponCode,
    String? discountAmount,
    String? subtotalWithDiscount,
    String? subtotal,
    String? grandTotal,
    String? weight,
    String? createdAt,
    String? updatedAt,
    String? walletValue,
    dynamic tokenId,
    int? orderStatus,
    List<ItemsCarts>? items,
  }) {
    return CartDataList(
      id: id ?? this.id,
      itemsCount: itemsCount ?? this.itemsCount,
      itemsQty: itemsQty ?? this.itemsQty,
      currencyCode: currencyCode ?? this.currencyCode,
      checkoutMethod: checkoutMethod ?? this.checkoutMethod,
      customerId: customerId ?? this.customerId,
      customerGroupId: customerGroupId ?? this.customerGroupId,
      customerFirstname: customerFirstname ?? this.customerFirstname,
      customerLastname: customerLastname ?? this.customerLastname,
      customerEmail: customerEmail ?? this.customerEmail,
      customerNote: customerNote ?? this.customerNote,
      customerNoteNotify: customerNoteNotify ?? this.customerNoteNotify,
      customerIsGuest: customerIsGuest ?? this.customerIsGuest,
      remoteIp: remoteIp ?? this.remoteIp,
      ruleIds: ruleIds ?? this.ruleIds,
      reservedOrderId: reservedOrderId ?? this.reservedOrderId,
      couponCode: couponCode ?? this.couponCode,
      discountAmount: discountAmount ?? this.discountAmount,
      subtotalWithDiscount: subtotalWithDiscount ?? this.subtotalWithDiscount,
      subtotal: subtotal ?? this.subtotal,
      grandTotal: grandTotal ?? this.grandTotal,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      walletValue: walletValue ?? this.walletValue,
      tokenId: tokenId ?? this.tokenId,
      orderStatus: orderStatus ?? this.orderStatus,
      items: items ?? this.items,
    );
  }
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

  ItemsCarts copyWith({
    int? id,
    int? quoteId,
    dynamic ruleIds,
    int? freeShipping,
    int? productId,
    dynamic additionalData,
    dynamic sku,
    dynamic productType,
    String? name,
    String? image,
    dynamic description,
    String? weight,
    String? qty,
    String? originPrice,
    String? salePrice,
    String? customPrice,
    String? discountPercent,
    String? discountAmount,
    String? taxPercent,
    String? taxAmount,
    String? rowTotalWithDiscount,
    String? rowTotal,
    String? rowWeight,
    String? rowTotalWithTax,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ItemsCarts(
      id: id ?? this.id,
      quoteId: quoteId ?? this.quoteId,
      ruleIds: ruleIds ?? this.ruleIds,
      freeShipping: freeShipping ?? this.freeShipping,
      productId: productId ?? this.productId,
      additionalData: additionalData ?? this.additionalData,
      sku: sku ?? this.sku,
      productType: productType ?? this.productType,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      qty: qty ?? this.qty,
      originPrice: originPrice ?? this.originPrice,
      salePrice: salePrice ?? this.salePrice,
      customPrice: customPrice ?? this.customPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      taxPercent: taxPercent ?? this.taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      rowTotalWithDiscount: rowTotalWithDiscount ?? this.rowTotalWithDiscount,
      rowTotal: rowTotal ?? this.rowTotal,
      rowWeight: rowWeight ?? this.rowWeight,
      rowTotalWithTax: rowTotalWithTax ?? this.rowTotalWithTax,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
