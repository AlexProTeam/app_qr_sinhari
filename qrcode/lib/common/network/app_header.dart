class AppHeader {
  String? accessToken;
  double? lat;
  double? lng;

  AppHeader({this.accessToken, this.lat, this.lng});

  AppHeader.fromLatLng(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }

  Map<String, String> toJson({String? contentType}) {
    final Map<String, String> data = Map<String, String>();
    if (accessToken != null) {
      data['Authorization'] = 'Bearer $accessToken';
      if (contentType != null) {
        data['Content-Type'] = 'application/json';
      }
    }
    return data;
  }
}
