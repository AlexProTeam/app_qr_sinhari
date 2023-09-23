import 'dart:convert';

class DetailByQr {
  bool? error;
  DataDetail? data;
  String? message;
  bool? success;

  DetailByQr({this.error, this.data, this.message, this.success});

  DetailByQr.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? DataDetail.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }
}

class DataDetail {
  DataDetailRoot? data;
  String? codeActive;
  Tracking? tracking;

  DataDetail({this.data, this.codeActive, this.tracking});

  DataDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataDetailRoot.fromJson(json['data']) : null;
    codeActive = json['code_active'];
    tracking =
        json['tracking'] != null ? Tracking.fromJson(json['tracking']) : null;
  }
}

class DataDetailRoot {
  int? id;
  String? name;
  dynamic aliasName;
  String? description;
  String? content;
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
  int? createdById;
  String? createdByType;
  String? image;
  dynamic barcode;
  int? costPerItem;
  dynamic storeId;
  int? approvedBy;
  int? generateLicenseCode;
  String? thumbnailImg;
  List<String>? photos;
  int? unitPrice;
  int? rating;
  int? purchasePrice;
  Status? status;
  Status? stockStatus;
  Status? productType;
  int? originalPrice;
  int? frontSalePrice;
  Slugable? slugable;
  DefaultVariation? defaultVariation;
  List<ProductCollections>? productCollections;
  List<dynamic>? productLabels;
  List<Categories>? categories;

  DataDetailRoot(
      {this.id,
      this.name,
      this.aliasName,
      this.description,
      this.content,
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
      this.createdById,
      this.createdByType,
      this.image,
      this.barcode,
      this.costPerItem,
      this.storeId,
      this.approvedBy,
      this.generateLicenseCode,
      this.thumbnailImg,
      this.photos,
      this.unitPrice,
      this.rating,
      this.purchasePrice,
      this.status,
      this.stockStatus,
      this.productType,
      this.originalPrice,
      this.frontSalePrice,
      this.slugable,
      this.defaultVariation,
      this.productCollections,
      this.productLabels,
      this.categories});

  DataDetailRoot.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    aliasName = data['alias_name'];
    description = data['description'];
    content = data['content'];
    sku = data['sku'];
    order = data['order'];
    quantity = data['quantity'];
    allowCheckoutWhenOutOfStock = data['allow_checkout_when_out_of_stock'];
    withStorehouseManagement = data['with_storehouse_management'];
    isFeatured = data['is_featured'];
    isShowMobile = data['is_show_mobile'];
    isForVendor = data['is_for_vendor'];
    brandId = data['brand_id'];
    isVariation = data['is_variation'];
    saleType = data['sale_type'];
    price = data['price'];
    salePrice = data['sale_price'];
    startDate = data['start_date'];
    endDate = data['end_date'];
    length = data['length'];
    wide = data['wide'];
    height = data['height'];
    weight = data['weight'];
    taxId = data['tax_id'];
    views = data['views'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
    createdById = data['created_by_id'];
    createdByType = data['created_by_type'];
    image = data['image'];
    barcode = data['barcode'];
    costPerItem = data['cost_per_item'];
    storeId = data['store_id'];
    approvedBy = data['approved_by'];
    generateLicenseCode = data['generate_license_code'];
    thumbnailImg = data['thumbnail_img'];
    if (data['photos'] != null) {
      photos = [];
      final test = json.decode(data['photos']);
      for (final obj in test) {
        photos?.add(obj);
      }
    }
    unitPrice = data['unit_price'];
    rating = data['rating'];
    purchasePrice = data['purchase_price'];
    status = data['status'] != null ? Status.fromJson(data['status']) : null;
    stockStatus = data['stock_status'] != null
        ? Status.fromJson(data['stock_status'])
        : null;
    productType = data['product_type'] != null
        ? Status.fromJson(data['product_type'])
        : null;
    originalPrice = data['original_price'];
    frontSalePrice = data['front_sale_price'];
    slugable =
        data['slugable'] != null ? Slugable.fromJson(data['slugable']) : null;
    defaultVariation = data['default_variation'] != null
        ? DefaultVariation.fromJson(data['default_variation'])
        : null;
    if (data['product_collections'] != null) {
      productCollections = <ProductCollections>[];
      data['product_collections'].forEach((v) {
        productCollections!.add(ProductCollections.fromJson(v));
      });
    }
    if (data['product_labels'] != null) {
      productLabels = <Null>[];
      data['product_labels'].forEach((v) {
        // productLabels!.add(new Null.fromJson(v));
      });
    }
    if (data['categories'] != null) {
      categories = <Categories>[];
      data['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
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
}

class Slugable {
  int? id;
  String? key;
  String? referenceType;
  int? referenceId;
  String? prefix;

  Slugable(
      {this.id, this.key, this.referenceType, this.referenceId, this.prefix});

  Slugable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    referenceType = json['reference_type'];
    referenceId = json['reference_id'];
    prefix = json['prefix'];
  }
}

class DefaultVariation {
  int? configurableProductId;

  DefaultVariation({this.configurableProductId});

  DefaultVariation.fromJson(Map<String, dynamic> json) {
    configurableProductId = json['configurable_product_id'];
  }
}

class ProductCollections {
  int? id;
  String? name;
  String? slug;
  dynamic description;
  dynamic image;
  Status? status;
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
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFeatured = json['is_featured'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
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
}

class Categories {
  int? id;
  String? name;
  int? parentId;
  dynamic description;
  Status? status;
  int? order;
  String? image;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;
  PivotCategories? pivot;
  Slugable? slugable;

  Categories(
      {this.id,
      this.name,
      this.parentId,
      this.description,
      this.status,
      this.order,
      this.image,
      this.isFeatured,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.slugable});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    order = json['order'];
    image = json['image'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot =
        json['pivot'] != null ? PivotCategories.fromJson(json['pivot']) : null;
    slugable =
        json['slugable'] != null ? Slugable.fromJson(json['slugable']) : null;
  }
}

class PivotCategories {
  int? productId;
  int? categoryId;

  PivotCategories({this.productId, this.categoryId});

  PivotCategories.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
  }
}

class Tracking {
  int? totalScan;
  int? totalUserScan;
  bool? exceeded;
  String? datetimeScan;
  String? exceedingScan;

  Tracking(
      {this.totalScan,
      this.totalUserScan,
      this.exceeded,
      this.datetimeScan,
      this.exceedingScan});

  Tracking.fromJson(Map<String, dynamic> json) {
    totalScan = json['totalScan'];
    totalUserScan = json['totalUserScan'];
    exceeded = json['exceeded'];
    datetimeScan = json['datetime_scan'];
    exceedingScan = json['exceeding_scan'];
  }
}
