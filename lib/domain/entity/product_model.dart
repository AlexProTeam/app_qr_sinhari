class DataProduct {
  Product? data;

  DataProduct({this.data});

  DataProduct.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Product.fromJson(json['data']) : null;
  }
}

class Product {
  ProductFeatures? productFeatures;
  ProductSellers? productSellers;
  List<ProductResponse>? listAngecy;

  Product({this.productFeatures, this.productSellers, this.listAngecy});

  Product.fromJson(Map<String, dynamic> json) {
    productFeatures = json['productFeatures'] != null
        ? ProductFeatures.fromJson(json['productFeatures'])
        : null;
    productSellers = json['productSellers'] != null
        ? ProductSellers.fromJson(json['productSellers'])
        : null;
    if (json['products'] != null) {
      listAngecy = <ProductResponse>[];
      json['products'].forEach((v) {
        listAngecy!.add(ProductResponse.fromJson(v));
      });
    }
  }
}

class ProductSellers {
  List<ProductResponse>? list;

  ProductSellers({this.list});

  ProductSellers.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      list = <ProductResponse>[];
      json['data'].forEach((v) {
        list!.add(ProductResponse.fromJson(v));
      });
    }
  }
}

class ProductFeatures {
  List<ProductResponse>? list;

  ProductFeatures({this.list});

  ProductFeatures.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      list = <ProductResponse>[];
      json['data'].forEach((v) {
        list!.add(ProductResponse.fromJson(v));
      });
    }
  }
}

class ProductResponse {
  int? id;
  dynamic productIdVtap;
  String? name;
  String? productCode;
  String? addedBy;
  int? userId;
  int? categoryId;
  int? subcategoryId;
  int? subsubcategoryId;
  dynamic brandId;
  String? photos;
  String? thumbnailImg;
  String? thumbnailoptimize;
  String? featuredImg;
  String? flashDealImg;
  String? videoProvider;
  dynamic videoLink;
  String? tags;
  String? description;
  int? unitPrice;
  int? purchasePrice;
  String? choiceOptions;
  String? properties;
  String? attributes;
  String? colors;
  String? variations;
  int? todaysDeal;
  int? published;
  int? featured;
  int? currentStock;
  String? unit;
  int? discount;
  String? discountType;
  int? tax;
  String? taxType;
  String? shippingType;
  int? shippingCost;
  int? numOfSale;
  dynamic metaTitle;
  dynamic metaDescription;
  String? metaImg;
  String? pdf;
  String? slug;
  int? rating;
  String? createdAt;
  String? updatedAt;
  int? adminApproval;
  int? quantity;
  int? isDelete;
  String? deleteAt;
  int? deleteBy;
  int? isUpdate;
  String? otherSiteProductId;
  String? productBuyWith;
  int? isSale;
  int? isNew;

  //angecy
  String? content;
  int? price;
  int? salePrice;
  int? views;
  String? image;
  int? originalPrice;
  int? frontSalePrice;
  List<String>? productCollections;

  ProductResponse.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    productIdVtap = json['product_id_vtap'];
    name = json['name'];
    productCode = json['product_code'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subsubcategoryId = json['subsubcategory_id'];
    brandId = json['brand_id'];
    photos = json['photos'];
    thumbnailImg = json['thumbnail_img'];
    thumbnailoptimize = json['thumbnailoptimize'];
    featuredImg = json['featured_img'];
    flashDealImg = json['flash_deal_img'];
    videoProvider = json['video_provider'];
    videoLink = json['video_link'];
    tags = json['tags'];
    description = json['description'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    if (purchasePrice == 0) {
      purchasePrice = null;
    }
    choiceOptions = json['choice_options'];
    properties = json['properties'];
    attributes = json['attributes'];
    colors = json['colors'];
    variations = json['variations'];
    todaysDeal = json['todays_deal'];
    published = json['published'];
    featured = json['featured'];
    currentStock = json['current_stock'];
    unit = json['unit'];
    discount = json['discount'];
    discountType = json['discount_type'];
    tax = json['tax'];
    taxType = json['tax_type'];
    shippingType = json['shipping_type'];
    shippingCost = json['shipping_cost'];
    numOfSale = json['num_of_sale'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImg = json['meta_img'];
    pdf = json['pdf'];
    slug = json['slug'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminApproval = json['admin_approval'];
    quantity = json['quantity'];
    isDelete = json['is_delete'];
    deleteAt = json['delete_at'];
    deleteBy = json['delete_by'];
    isUpdate = json['is_update'];
    otherSiteProductId = json['other_site_product_id'];
    productBuyWith = json['product_buy_with'];
    isSale = json['is_sale'];
    isNew = json['is_new'];
    //angcy
    id = json['id'];
    name = json['name'];
    description = json['description'];
    content = json['content'];
    price = json['price'];
    salePrice = json['sale_price'];
    views = json['views'];
    image = json['image'];
    originalPrice = json['original_price'];
    frontSalePrice = json['front_sale_price'];
    if (json['product_collections'] != null) {
      productCollections = <String>[];
      json['product_collections'].forEach((v) {
        //   productCollections!.add( String.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    data['category_id'] = categoryId;
    data['subcategory_id'] = subcategoryId;
    data['subsubcategory_id'] = subsubcategoryId;
    data['thumbnail_img'] = thumbnailImg;
    data['unit_price'] = unitPrice;
    //angcy

    data['description'] = description;
    data['content'] = content;
    data['price'] = price;
    data['sale_price'] = salePrice;
    data['views'] = views;
    data['image'] = image;
    data['thumbnail_img'] = thumbnailImg;
    data['photos'] = photos;
    data['original_price'] = originalPrice;
    data['front_sale_price'] = frontSalePrice;
    return data;
  }
}
