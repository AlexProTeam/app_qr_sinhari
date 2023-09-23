import '../../domain/entity/product_model.dart';

class HomeCategoryResponse {
  int? id;
  int? categoryId;
  String? subCategory;
  String? subsubcategories;
  String? title;
  String? shortDescription;
  String? description;
  String? photo;
  String? photoThumbs;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? typeView;
  List<ProductResponse>? products;

  HomeCategoryResponse({
    this.id,
    this.categoryId,
    this.subCategory,
    this.subsubcategories,
    this.title,
    this.shortDescription,
    this.description,
    this.photo,
    this.photoThumbs,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.typeView,
    this.products,
  });

  HomeCategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    subsubcategories = json['subsubcategories'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    photo = json['photo'];
    photoThumbs = json['photo_thumbs'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeView = json['type_view'];
    if (json['products'] != null) {
      products = <ProductResponse>[];
      json['products'].forEach((v) {
        products!.add(ProductResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category'] = subCategory;
    data['subsubcategories'] = subsubcategories;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['photo'] = photo;
    data['photo_thumbs'] = photoThumbs;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_view'] = typeView;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
