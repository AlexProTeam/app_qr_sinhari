# Getting Started

- Flutter version using : 3.7.10 (stable at 6/4/2023)
- Platform android : 33, Build-tools : 32.1.0-rc1
- Java version OpenJDK 11.0.12
- Gradle version 7.4
- Build:gradle 7.1.3
- Xcode: 14.2
- CocoaPods version 1.11.3

# FVM install
- `There are a few ways to install FVM, and we are working on other ways to make it even simpler.`
- FVM Docs: `https://fvm.app/docs/getting_started/installation/`
- Run: `fvm use`

# How to gen all file
- run this code in terminal: `flutter packages pub run build_runner build --delete-conflicting-outputs`

# Build APK

- `flutter build apk --flavor {flavor_name}`
- For example: `flutter build apk --flavor dev`

# Build release with connect usb

- `flutter run --release --flavor "your_flavor" -t lib/"your_main_file_name".dart`
- Example: `flutter run --release --flavor dev -t lib/main.dart`


# how to use icon and font gen
- Example: `Assets.images.logo.image()`
- Example: `Assets.images.logo.path`

# if you are: Flutter Xcode 15 Error
- docs: `https://stackoverflow.com/questions/77136958/flutter-xcode-15-error-xcode-dt-toolchain-dir-cannot-be-used-to-evaluate-libr`
- file update: `app_qr_sinhari/ios/Podfile`
- add this to code: 
```
post_install do |installer|
  installer.pods_project.targets.each do |target|
     flutter_additional_ios_build_settings(target)
      target.build_configurations.each do |config|
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
  end
end
```

