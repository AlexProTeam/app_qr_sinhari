class DataListOrder {
  List<Orders>? orders;

  DataListOrder({this.orders});

  DataListOrder.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }
}

class Orders {
  int? id;
  String? code;
  int? userId;
  dynamic shippingOption;
  ShippingMethod? shippingMethod;
  ShippingMethod? status;
  String? amount;
  String? taxAmount;
  String? shippingAmount;
  dynamic description;
  String? couponCode;
  String? discountAmount;
  String? subTotal;
  int? isConfirmed;
  dynamic discountDescription;
  int? isFinished;
  dynamic completedAt;
  dynamic token;
  int? paymentId;
  String? createdAt;
  String? updatedAt;
  dynamic storeId;
  List<Products>? products;

  Orders(
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

  Orders.fromJson(Map<String, dynamic> json) {
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
}

class Products {
  int? id;
  int? orderId;
  int? qty;
  String? price;
  String? taxAmount;
  OptionsOrder? options;
  List<String>? productOptions;
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
    options =
        json['options'] != null ? OptionsOrder.fromJson(json['options']) : null;
    if (json['product_options'] != null) {
      productOptions = <String>[];
      json['product_options'].forEach((v) {});
    }
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
}

class OptionsOrder {
  String? name;
  String? image;
  String? attributes;
  int? taxRate;
  List<String>? options;
  List<String>? extras;
  dynamic sku;
  int? weight;
  int? originalPrice;
  String? productLink;
  String? productType;
  int? commit;
  String? typeCommit;

  OptionsOrder(
      {this.name,
      this.image,
      this.attributes,
      this.taxRate,
      this.options,
      this.extras,
      this.sku,
      this.weight,
      this.originalPrice,
      this.productLink,
      this.productType,
      this.commit,
      this.typeCommit});

  OptionsOrder.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    attributes = json['attributes'];
    taxRate = json['taxRate'];
    if (json['options'] != null) {
      options = <String>[];
      json['options'].forEach((v) {});
    }
    if (json['extras'] != null) {
      extras = <String>[];
      json['extras'].forEach((v) {});
    }
    sku = json['sku'];
    weight = json['weight'];
    originalPrice = json['original_price'];
    productLink = json['product_link'];
    productType = json['product_type'];
    commit = json['commit'];
    typeCommit = json['type_commit'];
  }
}

class Product {
  int? id;
  String? name;
  String? aliasName;
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
  List<String>? productCollections;

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
      productCollections = <String>[];
      json['product_collections'].forEach((v) {});
    }
  }
}
