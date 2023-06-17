class WelcomeModel {
  int? id;
  String? Url;
  String? title;

  WelcomeModel.fromJson(Map<String, dynamic> data) {
    this.id = data['id'];
    this.Url = data['photo'];
    this.title = data['title'];
  }
// {
// "id": 3,
// "url": "111111111111111111111111111",
// "photo": "https://admin.sinhairvietnam.vn/uploads/files/21321.png",
// "title": "Tiêu đềTiêu đềTiêu đềTiêu đề"
// }
}
