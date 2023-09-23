class WelcomeModel {
  int? status;
  String? message;
  List<Banners>? banners;

  WelcomeModel({this.status, this.message, this.banners});

  WelcomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  int? simpleSliderId;
  String? title;
  String? image;
  String? link;
  String? description;
  int? order;
  String? createdAt;
  String? updatedAt;
  String? url;
  String? photo;

  Banners(
      {this.id,
      this.simpleSliderId,
      this.title,
      this.image,
      this.link,
      this.description,
      this.order,
      this.createdAt,
      this.updatedAt,
      this.url,
      this.photo});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    simpleSliderId = json['simple_slider_id'];
    title = json['title'];
    image = json['image'];
    link = json['link'];
    description = json['description'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['simple_slider_id'] = simpleSliderId;
    data['title'] = title;
    data['image'] = image;
    data['link'] = link;
    data['description'] = description;
    data['order'] = order;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['url'] = url;
    data['photo'] = photo;
    return data;
  }
}
