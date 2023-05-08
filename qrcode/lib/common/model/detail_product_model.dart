import 'dart:convert';

import 'package:qrcode/common/utils/log_util.dart';

class DetailProductModel {
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
  List<String>? photos;
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
  String? serialCode;
  int? countScan;
  int? countPersonScan;
  bool? limitScan;
  String? dateTimeScanLimit;
  String? exceedingScan;

  DetailProductModel.fromJson(Map<String?, dynamic> data) {
    id = data['id'];
    productIdVtap = data['product_id_vtap'];
    name = data['name'];
    productCode = data['product_code'];
    addedBy = data['added_by'];
    userId = data['user_id'];
    categoryId = data['category_id'];
    subcategoryId = data['subcategory_id'];
    subsubcategoryId = data['subsubcategory_id'];
    brandId = data['brand_id'];
    serialCode = data['code_active'];
    if (data['photos'] != null) {
      photos = [];
      final test = json.decode(data['photos']);
      for (final obj in test) {
        photos?.add(obj);
      }
    }
    thumbnailImg = data['thumbnail_img'];
    thumbnailoptimize = data['thumbnailoptimize'];
    featuredImg = data['featured_img'];
    flashDealImg = data['flash_deal_img'];
    videoProvider = data['video_provider'];
    videoLink = data['video_link'];
    tags = data['tags'];
    description = data['description'];
    unitPrice = data['unit_price'];
    purchasePrice = data['purchase_price'];
    choiceOptions = data['choice_options'];
    properties = data['properties'];
    attributes = data['attributes'];
    colors = data['colors'];
    variations = data['variations'];
    todaysDeal = data['todays_deal'];
    published = data['published'];
    featured = data['featured'];
    currentStock = data['current_stock'];
    unit = data['unit'];
    discount = data['discount'];
    discountType = data['discount_type'];
    tax = data['tax'];
    taxType = data['tax_type'];
    shippingType = data['shipping_type'];
    shippingCost = data['shipping_cost'];
    numOfSale = data['num_of_sale'];
    metaTitle = data['meta_title'];
    metaDescription = data['meta_description'];
    metaImg = data['meta_img'];
    pdf = data['pdf'];
    slug = data['slug'];
    rating = data['rating'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
    adminApproval = data['admin_approval'];
    quantity = data['quantity'];
    isDelete = data['is_delete'];
    deleteAt = data['delete_at'];
    deleteBy = data['delete_by'];
    isUpdate = data['is_update'];
    otherSiteProductId = data['other_site_product_id'];
    productBuyWith = data['product_buy_with'];
    isSale = data['is_sale'];
    isNew = data['is_new'];
    if (data['tracking'] != null) {
      countScan = data['tracking']['totalScan'];
      countPersonScan = data['tracking']['totalUserScan'];
      exceedingScan = data['tracking']['exceeding_scan'];
    }
  }
}
