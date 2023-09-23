class BannerResponse {
  String? url;
  int? id;
  String? title;
  String? urlLink;

  BannerResponse.fromJson(Map<String, dynamic> data) {
    url = data['photo_1'];
    id = data['id'];
    title = data['title_1'];
    urlLink = data['url_1'];
  }

  BannerResponse({
    this.id,
    this.title,
    this.urlLink,
    this.url,
  });
}
