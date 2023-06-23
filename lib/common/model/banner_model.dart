class BannerModel {
  String? url;
  int? id;
  String? title;
  String? urlLink;

  BannerModel.fromJson(Map<String, dynamic> data) {
    url = data['photo_1'];
    id = data['id'];
    title = data['title_1'];
    urlLink = data['url_1'];
  }
}
