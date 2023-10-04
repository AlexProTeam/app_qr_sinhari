enum FlavorManager {
  dev,
  staging,
  production,
}

class ConfigManager {
  final String apiBaseUrl;
  final FlavorManager appFlavor;

  ConfigManager._({
    required this.apiBaseUrl,
    required this.appFlavor,
  });

  static ConfigManager? _instance;

  static ConfigManager devConfig = ConfigManager._(
    apiBaseUrl: 'http://222.252.24.168:7456/api/',
    appFlavor: FlavorManager.dev,
  );

  static ConfigManager stagingConfig = ConfigManager._(
    apiBaseUrl: 'https://beta.sinhairvietnam.vn/api/',
    appFlavor: FlavorManager.staging,
  );

  static ConfigManager productionConfig = ConfigManager._(
    apiBaseUrl: 'https://beta.sinhairvietnam.vn/api/',
    appFlavor: FlavorManager.production,
  );

  static ConfigManager getInstance({String? flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'dev':
          _instance = devConfig;
          break;
        case 'staging':
          _instance = stagingConfig;
          break;
        case 'production':
          _instance = productionConfig;
          break;
        default:
          _instance = devConfig;
          break;
      }

      return _instance!;
    } else {
      return _instance!;
    }
  }
}
