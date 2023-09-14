class WelcomeModel {
  int? id;
  String? url;
  String? title;

  WelcomeModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    url = data['photo'];
    title = data['title'];
  }
}
