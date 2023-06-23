class AppHeader {
  String? accessToken;
  double? lat;
  double? lng;

  AppHeader({this.accessToken, this.lat, this.lng});

  AppHeader.fromLatLng(double this.lat, double this.lng);

  Map<String, String> toJson({String? contentType}) {
    final Map<String, String> data = <String, String>{};
    if (accessToken != null) {
      data['Authorization'] = 'Bearer $accessToken';
      if (contentType != null) {
        data['Content-Type'] = 'application/json';
      }
    }
    return data;
  }
}
