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

