class AppHeader {
  String? accessToken;
  double? lat;
  double? lng;

  AppHeader({this.accessToken, this.lat, this.lng});

  AppHeader.fromJson(Map<String, dynamic> json) {
    accessToken = json['Authorization'];
  }

  AppHeader.fromLatLng(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }

  Map<String, String> toJson() {
    final Map<String, String> data = Map<String, String>();
    if (accessToken != null) {
      data['token'] = '$accessToken';
      data['Content-Type'] = 'application/json';
    }
    return data;
  }

  Map<String, String> toJson2() {
    final Map<String, String> data = Map<String, String>();
    if (accessToken != null) {
      data['token'] = '$accessToken';
      data['latitude'] = '$lat';
      data['longitude'] = '$lng';
    }
    return data;
  }
}
