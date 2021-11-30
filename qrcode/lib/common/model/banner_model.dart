class BannerModel {
  String? url;
  int? id;
  String? title;

  BannerModel.fromJson(Map<String, dynamic> data) {
    url = data['photo_1'];
    id = data['id'];
    title = data['title_1'];
  }
}
