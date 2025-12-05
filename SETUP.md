# Quick Setup Guide

## Step 1: Install Dependencies

```bash
flutter pub get
```

## Step 2: Configure API Key

1. Get your free API key from [OpenWeatherMap](https://openweathermap.org/api)
2. Open `lib/config/api_config.dart`
3. Replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String apiKey = 'your_actual_api_key_here';
```

## Step 3: Run the App

```bash
flutter run
```

## Step 4: Build APK

To build a release APK:

```bash
flutter build apk --release
```

The APK will be located at:
```
build/app/outputs/flutter-apk/app-release.apk
```

## Troubleshooting

- If you get API errors, verify your API key is correct
- Ensure you have internet connection
- Run `flutter doctor` to check Flutter setup
- Run `flutter clean` if you encounter build issues
