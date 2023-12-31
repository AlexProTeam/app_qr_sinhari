class DataListOrder {
  List<OrdersHistoryResponse>? orders;

  DataListOrder({this.orders});

  DataListOrder.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <OrdersHistoryResponse>[];
      json['orders'].forEach((v) {
        orders!.add(OrdersHistoryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersHistoryResponse {
  int? id;
  String? code;
  int? userId;
  dynamic shippingOption;
  ShippingMethod? shippingMethod;
  ShippingMethod? status;
  String? amount;
  dynamic taxAmount;
  dynamic shippingAmount;
  String? description;
  dynamic couponCode;
  dynamic discountAmount;
  String? subTotal;
  int? isConfirmed;
  dynamic discountDescription;
  int? isFinished;
  dynamic completedAt;
  dynamic token;
  dynamic paymentId;
  String? createdAt;
  String? updatedAt;
  dynamic storeId;
  List<Products>? products;
  int? totalQty;

  OrdersHistoryResponse(
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
      this.products,
      this.totalQty});

  OrdersHistoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    shippingOption = json['shipping_option'];
    shippingMethod = json['shipping_method'] != null
        ? ShippingMethod.fromJson(json['shipping_method'])
        : null;
    status =
        json['status'] != null ? ShippingMethod.fromJson(json['status']) : null;
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
    totalQty = json['total_qty'];
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
    data['total_qty'] = totalQty;
    return data;
  }
}

class ShippingMethod {
  String? value;
  String? label;

  ShippingMethod({this.value, this.label});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
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

class Products {
  int? id;
  int? orderId;
  int? qty;
  String? price;
  String? taxAmount;

  ///todo: check
  List<dynamic>? options;
  List<dynamic>? productOptions;
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
  Product? product;

  Products(
      {this.id,
      this.orderId,
      this.qty,
      this.price,
      this.taxAmount,
      this.options,
      this.productOptions,
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
      this.product});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    qty = json['qty'];
    price = json['price'];
    taxAmount = json['tax_amount'];

    ///todo: check
    // if (json['options'] != null) {
    //   options = <Null>[];
    //   json['options'].forEach((v) {
    //     options!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['product_options'] != null) {
    //   productOptions = <Null>[];
    //   json['product_options'].forEach((v) {
    //     productOptions!.add(Null.fromJson(v));
    //   });
    // }
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
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['qty'] = qty;
    data['price'] = price;
    data['tax_amount'] = taxAmount;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (productOptions != null) {
      data['product_options'] = productOptions!.map((v) => v.toJson()).toList();
    }
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
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  dynamic aliasName;
  String? description;
  String? content;
  ShippingMethod? status;
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
  int? salePrice;
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
  ShippingMethod? stockStatus;
  int? createdById;
  String? createdByType;
  String? image;
  ShippingMethod? productType;
  dynamic barcode;
  int? costPerItem;
  dynamic storeId;
  int? approvedBy;
  int? generateLicenseCode;
  int? originalPrice;
  int? frontSalePrice;
  List<ProductCollections>? productCollections;

  Product(
      {this.id,
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
      this.productCollections});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    aliasName = json['alias_name'];
    description = json['description'];
    content = json['content'];
    status =
        json['status'] != null ? ShippingMethod.fromJson(json['status']) : null;
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
        ? ShippingMethod.fromJson(json['stock_status'])
        : null;
    createdById = json['created_by_id'];
    createdByType = json['created_by_type'];
    image = json['image'];
    productType = json['product_type'] != null
        ? ShippingMethod.fromJson(json['product_type'])
        : null;
    barcode = json['barcode'];
    costPerItem = json['cost_per_item'];
    storeId = json['store_id'];
    approvedBy = json['approved_by'];
    generateLicenseCode = json['generate_license_code'];
    originalPrice = json['original_price'];
    frontSalePrice = json['front_sale_price'];
    if (json['product_collections'] != null) {
      productCollections = <ProductCollections>[];
      json['product_collections'].forEach((v) {
        productCollections!.add(ProductCollections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias_name'] = aliasName;
    data['description'] = description;
    data['content'] = content;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['images'] = images;
    data['sku'] = sku;
    data['order'] = order;
    data['quantity'] = quantity;
    data['allow_checkout_when_out_of_stock'] = allowCheckoutWhenOutOfStock;
    data['with_storehouse_management'] = withStorehouseManagement;
    data['is_featured'] = isFeatured;
    data['is_show_mobile'] = isShowMobile;
    data['is_for_vendor'] = isForVendor;
    data['brand_id'] = brandId;
    data['is_variation'] = isVariation;
    data['sale_type'] = saleType;
    data['price'] = price;
    data['sale_price'] = salePrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['length'] = length;
    data['wide'] = wide;
    data['height'] = height;
    data['weight'] = weight;
    data['tax_id'] = taxId;
    data['views'] = views;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (stockStatus != null) {
      data['stock_status'] = stockStatus!.toJson();
    }
    data['created_by_id'] = createdById;
    data['created_by_type'] = createdByType;
    data['image'] = image;
    if (productType != null) {
      data['product_type'] = productType!.toJson();
    }
    data['barcode'] = barcode;
    data['cost_per_item'] = costPerItem;
    data['store_id'] = storeId;
    data['approved_by'] = approvedBy;
    data['generate_license_code'] = generateLicenseCode;
    data['original_price'] = originalPrice;
    data['front_sale_price'] = frontSalePrice;
    if (productCollections != null) {
      data['product_collections'] =
          productCollections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCollections {
  int? id;
  String? name;
  String? slug;
  dynamic description;
  dynamic image;
  ShippingMethod? status;
  String? createdAt;
  String? updatedAt;
  int? isFeatured;
  Pivot? pivot;

  ProductCollections(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isFeatured,
      this.pivot});

  ProductCollections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    status =
        json['status'] != null ? ShippingMethod.fromJson(json['status']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFeatured = json['is_featured'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['image'] = image;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_featured'] = isFeatured;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? productId;
  int? productCollectionId;

  Pivot({this.productId, this.productCollectionId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCollectionId = json['product_collection_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_collection_id'] = productCollectionId;
    return data;
  }
}
