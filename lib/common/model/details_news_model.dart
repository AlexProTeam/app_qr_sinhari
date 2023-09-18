class NewsDetails {
  int? status;
  String? message;
  Data? data;

  NewsDetails({this.status, this.message, this.data});

  NewsDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? description;
  String? content;
  int? isFeatured;
  String? image;
  int? views;
  int? formatType;
  String? createdAt;
  String? updatedAt;
  String? imageThumbs;
  String? title;
  String? slug;
  int? categoryNewsId;
  int? userId;
  String? urlVideo;
  int? pushed;
  int? hot;
  String? keyword;

  Data(
      {this.id,
        this.description,
        this.content,
        this.isFeatured,
        this.image,
        this.views,
        this.formatType,
        this.createdAt,
        this.updatedAt,
        this.imageThumbs,
        this.title,
        this.slug,
        this.categoryNewsId,
        this.userId,
        this.urlVideo,
        this.pushed,
        this.hot,
        this.keyword});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    content = json['content'];
    isFeatured = json['is_featured'];
    image = json['image'];
    views = json['views'];
    formatType = json['format_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageThumbs = json['image_thumbs'];
    title = json['title'];
    slug = json['slug'];
    categoryNewsId = json['category_news_id'];
    userId = json['user_id'];
    urlVideo = json['url_video'];
    pushed = json['pushed'];
    hot = json['hot'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['content'] = content;
    data['is_featured'] = isFeatured;
    data['image'] = image;
    data['views'] = views;
    data['format_type'] = formatType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_thumbs'] = imageThumbs;
    data['title'] = title;
    data['slug'] = slug;
    data['category_news_id'] = categoryNewsId;
    data['user_id'] = userId;
    data['url_video'] = urlVideo;
    data['pushed'] = pushed;
    data['hot'] = hot;
    data['keyword'] = keyword;
    return data;
  }
}
