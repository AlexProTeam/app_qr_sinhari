class HistoryDebtResponse {
  List<Withdrawals>? withdrawals;
  List<Debts>? debts;
  String? debtAble;
  int? customerId;

  HistoryDebtResponse(
      {this.withdrawals, this.debts, this.debtAble, this.customerId});

  HistoryDebtResponse.fromJson(Map<String, dynamic> json) {
    if (json['withdrawals'] != null) {
      withdrawals = <Withdrawals>[];
      json['withdrawals'].forEach((v) {
        withdrawals!.add(Withdrawals.fromJson(v));
      });
    }
    if (json['debts'] != null) {
      debts = <Debts>[];
      json['debts'].forEach((v) {
        debts!.add(Debts.fromJson(v));
      });
    }
    debtAble = json['debt_able'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (withdrawals != null) {
      data['withdrawals'] = withdrawals!.map((v) => v.toJson()).toList();
    }
    if (debts != null) {
      data['debts'] = debts!.map((v) => v.toJson()).toList();
    }
    data['debt_able'] = debtAble;
    data['customer_id'] = customerId;
    return data;
  }
}

class Withdrawals {
  int? id;
  int? customerId;
  String? fee;
  String? amount;
  String? currentBalance;
  dynamic currency;
  dynamic description;
  dynamic bankInfo;
  dynamic paymentChannel;
  int? userId;
  Status? status;
  dynamic images;
  String? createdAt;
  String? updatedAt;
  String? paymentCode;
  int? bankId;
  dynamic transactionId;

  Withdrawals(
      {this.id,
      this.customerId,
      this.fee,
      this.amount,
      this.currentBalance,
      this.currency,
      this.description,
      this.bankInfo,
      this.paymentChannel,
      this.userId,
      this.status,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.paymentCode,
      this.bankId,
      this.transactionId});

  Withdrawals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    fee = json['fee'];
    amount = json['amount'];
    currentBalance = json['current_balance'];
    currency = json['currency'];
    description = json['description'];
    bankInfo = json['bank_info'];
    paymentChannel = json['payment_channel'];
    userId = json['user_id'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    images = json['images'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentCode = json['payment_code'];
    bankId = json['bank_id'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['fee'] = fee;
    data['amount'] = amount;
    data['current_balance'] = currentBalance;
    data['currency'] = currency;
    data['description'] = description;
    data['bank_info'] = bankInfo;
    data['payment_channel'] = paymentChannel;
    data['user_id'] = userId;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['images'] = images;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['payment_code'] = paymentCode;
    data['bank_id'] = bankId;
    data['transaction_id'] = transactionId;
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

class Debts {
  int? id;
  int? customerId;
  int? orderId;
  String? subAmount;
  String? fee;
  String? amount;
  String? currentBalance;
  String? currency;
  int? userId;
  Status? type;
  String? description;
  String? createdAt;
  String? updatedAt;
  Order? order;

  Debts(
      {this.id,
      this.customerId,
      this.orderId,
      this.subAmount,
      this.fee,
      this.amount,
      this.currentBalance,
      this.currency,
      this.userId,
      this.type,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.order});

  Debts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    subAmount = json['sub_amount'];
    fee = json['fee'];
    amount = json['amount'];
    currentBalance = json['current_balance'];
    currency = json['currency'];
    userId = json['user_id'];
    type = json['type'] != null ? Status.fromJson(json['type']) : null;
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['order_id'] = orderId;
    data['sub_amount'] = subAmount;
    data['fee'] = fee;
    data['amount'] = amount;
    data['current_balance'] = currentBalance;
    data['currency'] = currency;
    data['user_id'] = userId;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  String? code;
  int? userId;
  dynamic shippingOption;
  Status? shippingMethod;
  Status? status;
  String? amount;
  String? taxAmount;
  String? shippingAmount;
  String? description;
  String? couponCode;
  String? discountAmount;
  String? subTotal;
  int? isConfirmed;
  dynamic discountDescription;
  int? isFinished;
  String? completedAt;
  dynamic token;
  int? paymentId;
  String? createdAt;
  String? updatedAt;
  dynamic storeId;
  List<Products>? products;

  Order(
      {this.id,
      this.code,
      this.userId,
      this.shippingOption,
      this.shippingMethod,
      this.status,
      this.amount,
      this.taxAmount,
      this.shippingAmount,
      this.description,
      this.couponCode,
      this.discountAmount,
      this.subTotal,
      this.isConfirmed,
      this.discountDescription,
      this.isFinished,
      this.completedAt,
      this.token,
      this.paymentId,
      this.createdAt,
      this.updatedAt,
      this.storeId,
      this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    shippingOption = json['shipping_option'];
    shippingMethod = json['shipping_method'] != null
        ? Status.fromJson(json['shipping_method'])
        : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    shippingAmount = json['shipping_amount'];
    description = json['description'];
    couponCode = json['coupon_code'];
    discountAmount = json['discount_amount'];
    subTotal = json['sub_total'];
    isConfirmed = json['is_confirmed'];
    discountDescription = json['discount_description'];
    isFinished = json['is_finished'];
    completedAt = json['completed_at'];
    token = json['token'];
    paymentId = json['payment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeId = json['store_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['user_id'] = userId;
    data['shipping_option'] = shippingOption;
    if (shippingMethod != null) {
      data['shipping_method'] = shippingMethod!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['amount'] = amount;
    data['tax_amount'] = taxAmount;
    data['shipping_amount'] = shippingAmount;
    data['description'] = description;
    data['coupon_code'] = couponCode;
    data['discount_amount'] = discountAmount;
    data['sub_total'] = subTotal;
    data['is_confirmed'] = isConfirmed;
    data['discount_description'] = discountDescription;
    data['is_finished'] = isFinished;
    data['completed_at'] = completedAt;
    data['token'] = token;
    data['payment_id'] = paymentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['store_id'] = storeId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? orderId;
  int? qty;
  String? price;
  String? taxAmount;
  int? productId;
  String? productName;
  String? productImage;
  int? weight;
  int? restockQuantity;
  String? createdAt;
  String? updatedAt;
  String? productType;
  int? timesDownloaded;
  dynamic licenseCode;
  int? originPrice;

  Products({
    this.id,
    this.orderId,
    this.qty,
    this.price,
    this.taxAmount,
    this.productId,
    this.productName,
    this.productImage,
    this.weight,
    this.restockQuantity,
    this.createdAt,
    this.updatedAt,
    this.productType,
    this.timesDownloaded,
    this.licenseCode,
    this.originPrice,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    qty = json['qty'];
    price = json['price'];
    taxAmount = json['tax_amount'];

    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    weight = json['weight'];
    restockQuantity = json['restock_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productType = json['product_type'];
    timesDownloaded = json['times_downloaded'];
    licenseCode = json['license_code'];
    originPrice = json['origin_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['qty'] = qty;
    data['price'] = price;
    data['tax_amount'] = taxAmount;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['weight'] = weight;
    data['restock_quantity'] = restockQuantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_type'] = productType;
    data['times_downloaded'] = timesDownloaded;
    data['license_code'] = licenseCode;
    data['origin_price'] = originPrice;

    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? aliasName;
  String? description;
  String? content;
  Status? status;
  List<String>? images;
  dynamic sku;
  int? order;
  int? quantity;
  int? allowCheckoutWhenOutOfStock;
  int? withStorehouseManagement;
  int? isFeatured;
  int? isShowMobile;
  int? isForVendor;
  int? brandId;
  int? isVariation;
  int? saleType;
  int? price;
  dynamic salePrice;
  dynamic startDate;
  dynamic endDate;
  int? length;
  int? wide;
  int? height;
  int? weight;
  dynamic taxId;
  int? views;
  String? createdAt;
  String? updatedAt;
  Status? stockStatus;
  int? createdById;
  String? createdByType;
  String? image;
  Status? productType;
  dynamic barcode;
  int? costPerItem;
  dynamic storeId;
  int? approvedBy;
  int? generateLicenseCode;
  int? originalPrice;
  int? frontSalePrice;
  VariationInfo? variationInfo;

  Product({
    this.id,
    this.name,
    this.aliasName,
    this.description,
    this.content,
    this.status,
    this.images,
    this.sku,
    this.order,
    this.quantity,
    this.allowCheckoutWhenOutOfStock,
    this.withStorehouseManagement,
    this.isFeatured,
    this.isShowMobile,
    this.isForVendor,
    this.brandId,
    this.isVariation,
    this.saleType,
    this.price,
    this.salePrice,
    this.startDate,
    this.endDate,
    this.length,
    this.wide,
    this.height,
    this.weight,
    this.taxId,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.stockStatus,
    this.createdById,
    this.createdByType,
    this.image,
    this.productType,
    this.barcode,
    this.costPerItem,
    this.storeId,
    this.approvedBy,
    this.generateLicenseCode,
    this.originalPrice,
    this.frontSalePrice,
    this.variationInfo,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    aliasName = json['alias_name'];
    description = json['description'];
    content = json['content'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    images = json['images'].cast<String>();
    sku = json['sku'];
    order = json['order'];
    quantity = json['quantity'];
    allowCheckoutWhenOutOfStock = json['allow_checkout_when_out_of_stock'];
    withStorehouseManagement = json['with_storehouse_management'];
    isFeatured = json['is_featured'];
    isShowMobile = json['is_show_mobile'];
    isForVendor = json['is_for_vendor'];
    brandId = json['brand_id'];
    isVariation = json['is_variation'];
    saleType = json['sale_type'];
    price = json['price'];
    salePrice = json['sale_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    length = json['length'];
    wide = json['wide'];
    height = json['height'];
    weight = json['weight'];
    taxId = json['tax_id'];
    views = json['views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stockStatus = json['stock_status'] != null
        ? Status.fromJson(json['stock_status'])
        : null;
    createdById = json['created_by_id'];
    createdByType = json['created_by_type'];
    image = json['image'];
    productType = json['product_type'] != null
        ? Status.fromJson(json['product_type'])
        : null;
    barcode = json['barcode'];
    costPerItem = json['cost_per_item'];
    storeId = json['store_id'];
    approvedBy = json['approved_by'];
    generateLicenseCode = json['generate_license_code'];
    originalPrice = json['original_price'];
    frontSalePrice = json['front_sale_price'];
    variationInfo = json['variation_info'] != null
        ? VariationInfo.fromJson(json['variation_info'])
        : null;
  }
}

class VariationInfo {
  int? productId;

  VariationInfo({this.productId});

  VariationInfo.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
  }
}
