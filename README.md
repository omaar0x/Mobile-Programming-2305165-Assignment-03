# Weather App - Flutter Multi-Page Application

## Student Information
- **Name**: Omar Abdelall
- **Student ID**: 2305616
- **Course**: Flutter Mobile Development
- **Assignment**: Multi-Page Weather Application

---

## Project Overview

A comprehensive Flutter mobile application that retrieves and displays real-time weather data using the OpenWeatherMap Current Weather API. The app provides a complete weather experience with city search, detailed weather information, favorite cities management, and customizable settings.

### Key Highlights
- ✅ Multi-page navigation with Material Design
- ✅ Real-time weather data from OpenWeatherMap API
- ✅ State management using Provider pattern
- ✅ Local storage for favorites and settings
- ✅ Comprehensive error handling
- ✅ Clean, maintainable code structure
- ✅ Responsive UI with modern design

---

## Table of Contents

1. [Features](#features)
2. [Technical Stack](#technical-stack)
3. [Project Structure](#project-structure)
4. [Installation & Setup](#installation--setup)
5. [API Integration](#api-integration)
6. [Architecture & Design Patterns](#architecture--design-patterns)
7. [Error Handling](#error-handling)
8. [Building the Application](#building-the-application)
9. [Usage Guide](#usage-guide)
10. [Code Documentation](#code-documentation)
11. [Testing](#testing)
12. [Future Enhancements](#future-enhancements)

---

## Features

### 🏠 Home / Search Screen
- **City Search**: Search for weather by city name with real-time API integration
- **Search History**: Automatically saves last 5 searched cities for quick access
- **Quick Navigation**: Easy access to Favorites and Settings from app bar
- **User-Friendly Interface**: Clean search bar with intuitive design

### 🌤️ Weather Details Screen
Displays comprehensive weather information including:

- **City Name**: Current location being viewed
- **Temperature**: Current temperature with dynamic unit conversion (°C/°F)
- **Weather Description**: Human-readable weather conditions (e.g., "clear sky", "light rain")
- **Feels Like**: Perceived temperature based on humidity and wind
- **Humidity**: Air humidity percentage
- **Wind Speed**: Wind speed with appropriate units (km/h or mph)
- **Sunrise / Sunset**: Local sunrise and sunset times using timezone offset
- **Weather Icon**: Visual representation from OpenWeatherMap (high-quality icons)
- **Local Time**: Current local time calculated using timezone offset from API
- **Favorite Toggle**: Add/remove cities from favorites directly from details page

### ⭐ Favorites Screen
- **Favorite Cities List**: View all saved favorite cities in a scrollable list
- **Quick Access**: Tap any favorite to instantly view its weather details
- **Remove Favorites**: Delete cities from favorites with a single tap
- **Pull to Refresh**: Refresh the favorites list
- **Empty State**: Helpful message when no favorites are saved

### ⚙️ Settings Screen
- **Temperature Unit Selection**:
  - **Celsius (°C)**: Metric system (default)
  - **Fahrenheit (°F)**: Imperial system
  - Changes apply immediately across the app
- **App Information**: Version details and API provider information
- **Persistent Settings**: All preferences saved locally and restored on app restart

---

## Technical Stack

### Core Technologies
- **Framework**: Flutter 3.0.0+
- **Language**: Dart 3.0.0+
- **Platform**: Android (iOS compatible)

### Dependencies
- **provider** (^6.1.1): State management solution
- **http** (^1.1.0): HTTP client for API requests
- **shared_preferences** (^2.2.2): Local data persistence
- **intl** (^0.18.1): Internationalization and date formatting

### External Services
- **OpenWeatherMap Current Weather API**: Real-time weather data provider
  - API Documentation: https://openweathermap.org/current
  - Free tier: 60 calls/minute, 1,000,000 calls/month

---

## Project Structure

```
weather_/
├── lib/
│   ├── config/
│   │   ├── api_config.dart          # API configuration and key management
│   │   └── api_config.dart.example  # Example config file template
│   ├── models/
│   │   └── weather_model.dart       # Weather data model with conversion methods
│   ├── services/
│   │   ├── api_service.dart         # OpenWeatherMap API integration service
│   │   └── storage_service.dart     # Local storage management (SharedPreferences)
│   ├── providers/
│   │   └── weather_provider.dart    # State management with Provider pattern
│   ├── pages/
│   │   ├── home_page.dart           # Home/Search screen implementation
│   │   ├── weather_details_page.dart # Weather details screen with all metrics
│   │   ├── favorites_page.dart      # Favorites management screen
│   │   └── settings_page.dart       # Settings and preferences screen
│   └── main.dart                    # App entry point and routing configuration
├── android/                         # Android platform configuration
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml  # App permissions and configuration
│   │   │   └── kotlin/.../MainActivity.kt
│   │   └── build.gradle
│   └── build.gradle
├── pubspec.yaml                     # Flutter dependencies and metadata
├── README.md                        # This documentation file
└── .gitignore                       # Git ignore rules (includes API key protection)
```

### Code Organization Principles
- **Separation of Concerns**: Each layer has a specific responsibility
- **Single Responsibility**: Each class/function has one clear purpose
- **DRY (Don't Repeat Yourself)**: Reusable components and utilities
- **Clean Architecture**: Models, Services, Providers, and UI layers separated

---

## Installation & Setup

### Prerequisites

Before starting, ensure you have the following installed:

1. **Flutter SDK** (3.0.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter doctor`

2. **Dart SDK** (comes with Flutter)

3. **Development Environment**:
   - Android Studio / IntelliJ IDEA with Flutter plugin, OR
   - VS Code with Flutter extension

4. **Android Development**:
   - Android SDK
   - Android Studio or Android SDK Command-line Tools
   - An Android device or emulator

5. **OpenWeatherMap API Key** (Free tier available)
   - Sign up at: https://openweathermap.org/api
   - Get your API key from the dashboard

### Step-by-Step Installation

#### 1. Clone or Download the Project
```bash
# If using Git
git clone <repository-url>
cd weather_

# Or extract the project folder if downloaded as ZIP
```

#### 2. Install Flutter Dependencies
```bash
flutter pub get
```

This command will download and install all required packages listed in `pubspec.yaml`.

#### 3. Configure API Key

The API key is already configured in `lib/config/api_config.dart` with the provided key. However, if you need to change it:

1. Open `lib/config/api_config.dart`
2. Replace the `apiKey` value:
   ```dart
   static const String apiKey = 'YOUR_API_KEY_HERE';
   ```

**Security Note**: 
- The `api_config.dart` file is included in `.gitignore` to prevent committing API keys
- Never commit API keys to public repositories
- For production apps, consider using environment variables or secure storage

#### 4. Verify Setup
```bash
flutter doctor
flutter analyze
```

#### 5. Run the Application

**On Android Emulator/Device:**
```bash
flutter run
```

**On Specific Device:**
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

---

## API Integration

### OpenWeatherMap Current Weather API

The application uses the OpenWeatherMap Current Weather Data API to fetch real-time weather information.

#### API Endpoint
```
GET https://api.openweathermap.org/data/2.5/weather
```

#### Request Parameters
- `q`: City name (e.g., "London", "New York", "Cairo")
- `appid`: Your API key

#### Example Request
```
https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY
```

#### API Response Structure
The API returns JSON data including:
- `main`: Temperature, feels like, humidity, pressure
- `weather`: Description, icon code
- `wind`: Wind speed and direction
- `sys`: Sunrise, sunset, country
- `timezone`: Timezone offset in seconds
- `name`: City name

#### Implementation Details

**API Service** (`lib/services/api_service.dart`):
- Handles HTTP requests using the `http` package
- Implements error handling for various HTTP status codes
- Throws descriptive exceptions for different error scenarios
- Supports both city name and coordinate-based queries

**Weather Model** (`lib/models/weather_model.dart`):
- Parses JSON response into a structured Dart object
- Provides temperature conversion methods (Kelvin → Celsius/Fahrenheit)
- Calculates wind speed in appropriate units
- Formats timezone-aware timestamps

#### API Rate Limits
- Free tier: 60 calls/minute
- Free tier: 1,000,000 calls/month
- The app handles rate limit errors (HTTP 429) gracefully

---

## Architecture & Design Patterns

### State Management: Provider Pattern

The application uses the **Provider** pattern for state management, which provides:
- Centralized state management
- Reactive UI updates
- Easy testing and debugging
- Separation of business logic from UI

#### WeatherProvider (`lib/providers/weather_provider.dart`)

Manages all application state:

**State Variables:**
- `_currentWeather`: Current weather data model
- `_isLoading`: Loading state indicator
- `_errorMessage`: Error message for display
- `_isCelsius`: Temperature unit preference
- `_favorites`: List of favorite city names

**Key Methods:**
- `fetchWeatherByCity(String)`: Fetches weather data for a city
- `addFavorite(String)`: Adds city to favorites
- `removeFavorite(String)`: Removes city from favorites
- `setTemperatureUnit(bool)`: Updates temperature unit preference
- `reloadFavorites()`: Refreshes favorites list from storage

### Service Layer Pattern

**API Service** (`lib/services/api_service.dart`):
- Handles all external API communication
- Encapsulates API-specific logic
- Provides clean interface for data fetching

**Storage Service** (`lib/services/storage_service.dart`):
- Manages local data persistence
- Abstracts SharedPreferences implementation
- Provides type-safe storage operations

### Model-View-Provider (MVP) Architecture

```
┌─────────────┐
│    View     │  (Pages/UI)
│  (Pages)    │
└──────┬──────┘
       │
       │ Uses
       ▼
┌─────────────┐
│  Provider   │  (State Management)
│ (Provider)  │
└──────┬──────┘
       │
       │ Uses
       ▼
┌─────────────┐     ┌─────────────┐
│   Service   │────▶│    Model    │
│  (API/DB)   │     │  (Weather)  │
└─────────────┘     └─────────────┘
```

---

## Error Handling

The application implements comprehensive error handling for various scenarios:

### Network Errors
- **No Internet Connection**: 
  - Detected via `http.ClientException`
  - Shows user-friendly message: "No internet connection. Please check your network."
  - Provides retry option

### API Errors
- **401 Unauthorized**: Invalid API key
  - Error message: "Invalid API key. Please check your API configuration."
  
- **404 Not Found**: City not found
  - Error message: "City not found. Please check the city name."
  
- **429 Too Many Requests**: Rate limit exceeded
  - Error message: "API rate limit exceeded. Please try again later."
  
- **Other HTTP Errors**: Generic error with status code
  - Error message: "Failed to load weather data. Status code: XXX"

### User Experience
- **Loading States**: Circular progress indicator during API calls
- **Error Display**: Clear error messages with retry functionality
- **Empty States**: Helpful messages when no data is available
- **Input Validation**: Prevents empty city name searches

### Error Handling Implementation

```dart
try {
  // API call
} on http.ClientException {
  // Network error
} catch (e) {
  // Other errors
}
```

---

## Building the Application

### Android APK Build

#### 1. Release APK (Single File)
```bash
flutter build apk --release
```
**Output Location**: `build/app/outputs/flutter-apk/app-release.apk`

**File Size**: ~30-40 MB (includes all architectures)

#### 2. Split APKs (Recommended - Smaller Size)
```bash
flutter build apk --split-per-abi
```
**Output Location**: `build/app/outputs/flutter-apk/`

Creates separate APKs for:
- `app-armeabi-v7a-release.apk` (~10 MB)
- `app-arm64-v8a-release.apk` (~10 MB)
- `app-x86_64-release.apk` (~10 MB)

**Benefits**: Smaller file size, faster downloads

#### 3. App Bundle (For Google Play Store)
```bash
flutter build appbundle --release
```
**Output Location**: `build/app/outputs/bundle/release/app-release.aab`

### iOS Build (Optional)

#### 1. Build iOS App
```bash
flutter build ios --release
```

#### 2. Open in Xcode
```bash
open ios/Runner.xcworkspace
```

#### 3. Configure Signing
- Select your development team
- Configure signing certificates

#### 4. Archive and Distribute
- Product → Archive
- Distribute through App Store or TestFlight

### Build Configuration

**Minimum SDK Versions:**
- Android: API 21 (Android 5.0 Lollipop)
- iOS: iOS 12.0+

**Target SDK:**
- Android: Latest stable
- iOS: Latest stable

---

## Usage Guide

### For End Users

#### Searching for Weather
1. Open the app
2. Enter a city name in the search bar
3. Tap "Search" or press Enter
4. View detailed weather information

#### Adding Favorites
1. Search for a city
2. On the weather details page, tap the heart icon in the app bar
3. The city is now saved to favorites

#### Viewing Favorites
1. Tap the heart icon in the home screen app bar
2. Browse your saved favorite cities
3. Tap any city to view its current weather
4. Swipe down to refresh the list

#### Changing Temperature Units
1. Tap the settings icon in the app bar
2. Select your preferred unit:
   - Celsius (°C) for metric
   - Fahrenheit (°F) for imperial
3. Changes apply immediately across the app

#### Viewing Weather Details
The weather details screen shows:
- Large temperature display with icon
- Weather description
- Local time
- Feels like temperature
- Humidity percentage
- Wind speed
- Sunrise time
- Sunset time

### For Developers

#### Adding New Features
1. **New API Endpoint**: Add method to `api_service.dart`
2. **New Model**: Create model in `models/` directory
3. **New State**: Add to `weather_provider.dart`
4. **New UI**: Create page in `pages/` directory

#### Modifying API Configuration
- Edit `lib/config/api_config.dart`
- Update API key or base URL as needed

#### Debugging
```bash
# Run in debug mode
flutter run

# Run with verbose logging
flutter run -v

# Analyze code
flutter analyze

# Check for issues
flutter doctor -v
```

---

## Code Documentation

### Key Classes and Methods

#### WeatherModel (`lib/models/weather_model.dart`)
```dart
class WeatherModel {
  // Properties
  final String cityName;
  final double temperature;  // In Kelvin
  final double feelsLike;
  final int humidity;
  final double windSpeed;    // In m/s
  
  // Conversion Methods
  double getTemperatureInUnit(bool isCelsius)
  double getFeelsLikeInUnit(bool isCelsius)
  double getWindSpeedInUnit(bool isMetric)
  
  // Icon URL
  String get iconUrl
}
```

#### ApiService (`lib/services/api_service.dart`)
```dart
class ApiService {
  // Fetch weather by city name
  Future<WeatherModel> getWeatherByCityName(String cityName)
  
  // Fetch weather by coordinates (optional)
  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon)
}
```

#### WeatherProvider (`lib/providers/weather_provider.dart`)
```dart
class WeatherProvider with ChangeNotifier {
  // Getters
  WeatherModel? get currentWeather
  bool get isLoading
  String? get errorMessage
  bool get isCelsius
  List<String> get favorites
  
  // Methods
  Future<void> fetchWeatherByCity(String cityName)
  Future<void> addFavorite(String cityName)
  Future<void> removeFavorite(String cityName)
  Future<void> setTemperatureUnit(bool isCelsius)
}
```

#### StorageService (`lib/services/storage_service.dart`)
```dart
class StorageService {
  // Favorites
  Future<bool> addFavorite(String cityName)
  Future<bool> removeFavorite(String cityName)
  Future<List<String>> getFavoritesAsync()
  Future<bool> isFavorite(String cityName)
  
  // Settings
  Future<bool> setIsCelsius(bool isCelsius)
  Future<bool> getIsCelsius()
}
```

### Code Comments
- All classes have descriptive comments
- Complex logic is explained inline
- API methods include parameter descriptions
- Error handling is documented

---

## Testing

### Manual Testing Checklist

#### Home Screen
- [ ] Search bar accepts input
- [ ] Search button triggers navigation
- [ ] Search history displays correctly
- [ ] Navigation to favorites works
- [ ] Navigation to settings works

#### Weather Details Screen
- [ ] All weather data displays correctly
- [ ] Temperature converts based on settings
- [ ] Weather icon loads properly
- [ ] Favorite toggle works
- [ ] Error messages display for invalid cities
- [ ] Loading indicator shows during API calls

#### Favorites Screen
- [ ] Favorites list displays correctly
- [ ] Adding favorites works
- [ ] Removing favorites works
- [ ] Navigation to weather details works
- [ ] Empty state displays when no favorites

#### Settings Screen
- [ ] Temperature unit selection works
- [ ] Changes apply immediately
- [ ] Settings persist after app restart

### Automated Testing (Future Enhancement)
- Unit tests for models and services
- Widget tests for UI components
- Integration tests for user flows

---

## Future Enhancements

### Planned Features
- [ ] **GPS Location Support**: Automatic weather based on device location
- [ ] **Weather Forecasts**: 5-day and 3-hour forecast views
- [ ] **Multiple Languages**: Internationalization support
- [ ] **Dark Mode**: Theme switching capability
- [ ] **Weather Maps**: Interactive weather maps
- [ ] **Push Notifications**: Weather alerts and updates
- [ ] **Home Screen Widgets**: Quick weather access
- [ ] **Weather History**: Historical weather data
- [ ] **Multiple Locations**: Compare weather across cities
- [ ] **Offline Mode**: Cached weather data for offline access

### Technical Improvements
- [ ] Unit and integration tests
- [ ] Code coverage reports
- [ ] CI/CD pipeline
- [ ] Performance optimization
- [ ] Accessibility improvements
- [ ] Analytics integration

---

## Troubleshooting

### Common Issues

#### Issue: "Target of URI doesn't exist" errors
**Solution**: Run `flutter pub get` to install dependencies

#### Issue: API returns 401 Unauthorized
**Solution**: Check your API key in `lib/config/api_config.dart`

#### Issue: City not found
**Solution**: 
- Verify city name spelling
- Try using "City, Country" format
- Check internet connection

#### Issue: App crashes on launch
**Solution**:
- Run `flutter clean`
- Run `flutter pub get`
- Restart the app

#### Issue: Favorites not saving
**Solution**:
- Check app permissions
- Verify SharedPreferences is working
- Check device storage space

---

## License

This project is created for educational purposes as part of a Flutter mobile development assignment.

---

## Acknowledgments

- **OpenWeatherMap**: For providing the comprehensive weather API
  - Website: https://openweathermap.org/
  - API Documentation: https://openweathermap.org/api

- **Flutter Team**: For the excellent cross-platform framework
  - Website: https://flutter.dev/
  - Documentation: https://flutter.dev/docs

- **Provider Package**: For state management solution
  - Package: https://pub.dev/packages/provider

---

## Contact & Support

**Student**: Omar Abdelall  
**Student ID**: 2305616

For questions or issues regarding this assignment:
- Check the troubleshooting section above
- Review the code comments for implementation details
- Refer to Flutter and OpenWeatherMap documentation

---

## Assignment Checklist

### Requirements Met ✅

- [x] Multi-page Flutter application
- [x] Home/Search Screen with city search
- [x] Weather Details Screen with all required data
- [x] Favorites Screen with save/remove functionality
- [x] Settings Screen with temperature unit selection
- [x] OpenWeatherMap Current Weather API integration
- [x] Proper error handling (network, API, invalid input)
- [x] State management using Provider
- [x] Local storage using SharedPreferences
- [x] Clean folder structure
- [x] API service in separate file
- [x] API key in config file (not hardcoded)
- [x] Weather icons from OpenWeatherMap
- [x] Timezone handling for local time
- [x] Temperature conversion (°C/°F)
- [x] Wind speed unit conversion
- [x] Sunrise/Sunset times
- [x] Loading indicators
- [x] Responsive UI design
- [x] Complete documentation (README)

---

**Last Updated**: 2024  
**Version**: 1.0.0  
**Flutter Version**: 3.0.0+  
**Dart Version**: 3.0.0+

---

**Note**: This application is developed as an educational assignment. The API key provided is for demonstration purposes. For production use, implement proper API key management and security practices.
