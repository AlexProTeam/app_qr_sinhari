class Helper {
  static Helper? _instance;

  static Future<Helper?> getInstance() async {
    _instance ??= Helper();

    return _instance;
  }

  static bool getPrice(int priceSale, int price) {
    if (priceSale == price) {
      return true;
    }
    return false;
  }
}
