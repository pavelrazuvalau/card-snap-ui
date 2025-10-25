# 📱 Mobile Development Setup Guide

## Android Development

### Prerequisites
1. **Install Android Studio** from [developer.android.com](https://developer.android.com/studio)
2. **Install Android SDK** (Android Studio will guide you)
3. **Set up Android emulator** or connect physical device

### Setup Steps
```bash
# Check Android setup
flutter doctor

# If Android SDK not found, set path manually
flutter config --android-sdk <path-to-android-sdk>

# List available devices
flutter devices

# Run on Android
flutter run -d android
```

### Build Android APK
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App Bundle (recommended for Play Store)
flutter build appbundle --release
```

## iOS Development (macOS only)

### Prerequisites
1. **Install Xcode** from Mac App Store
2. **Install Xcode Command Line Tools**
3. **Set up iOS Simulator** or connect physical device

### Setup Steps
```bash
# Check iOS setup
flutter doctor

# List available devices
flutter devices

# Run on iOS
flutter run -d ios
```

### Build iOS App
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

## Web Development (Local Testing)

### Quick Start
```bash
# Windows
run_web.bat

# Linux/Mac
./run_web.sh

# Manual
flutter run -d chrome
```

### Build Web
```bash
flutter build web
```

## Troubleshooting

### Common Issues
1. **Android SDK not found**: Install Android Studio and set SDK path
2. **iOS development on Windows**: Not supported, use macOS or web development
3. **Device not detected**: Enable USB debugging (Android) or trust computer (iOS)

### Useful Commands
```bash
# Check Flutter setup
flutter doctor -v

# Clean and rebuild
flutter clean
flutter pub get

# Check connected devices
flutter devices

# Run specific test
flutter test test/widget_test.dart
```

## Next Steps

1. **Set up Android Studio** for Android development
2. **Install Xcode** for iOS development (macOS only)
3. **Connect physical devices** for testing
4. **Add dependencies** from `pubspec.yaml` TODO sections
5. **Implement features** following Clean Architecture

---

*Web development is ready to use for local testing! 🚀*
