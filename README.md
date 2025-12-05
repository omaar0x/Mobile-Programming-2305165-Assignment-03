# Weather App - Flutter Multi-Page Application

A comprehensive Flutter mobile application that retrieves and displays real-time weather data using the OpenWeatherMap Current Weather API. The app features city search, detailed weather information, favorite cities management, and customizable settings.

## Features

### 🏠 Home / Search Screen
- Search for weather by city name
- Search history (last 10 searches)
- Quick access to favorites and settings
- Clean and intuitive UI

### 📊 Weather Details Screen
- **City Information**: City name and country
- **Temperature**: Current temperature with unit preference
- **Weather Description**: Current weather conditions
- **Feels Like**: Perceived temperature
- **Humidity**: Percentage of humidity
- **Wind Speed**: Current wind speed
- **Sunrise/Sunset**: Times adjusted for local timezone
- **Local Time**: Current time in the city's timezone
- **Weather Icon**: Visual representation from OpenWeatherMap
- **Favorite Toggle**: Add/remove cities from favorites

### ⭐ Favorites Screen
- View all saved favorite cities
- Quick navigation to weather details
- Remove cities from favorites
- Empty state with helpful message

### ⚙️ Settings Screen
- **Temperature Unit Selection**:
  - Celsius (°C) - Metric system
  - Fahrenheit (°F) - Imperial system
- App information and version details

## Technical Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **HTTP Client**: http package
- **API**: OpenWeatherMap Current Weather API
- **Routing**: Named routes with MaterialPageRoute

## Project Structure

```
lib/
├── config/
│   └── api_config.dart          # API configuration (API key)
├── models/
│   ├── weather_model.dart       # Weather data model
│   └── app_state.dart           # Application state model
├── pages/
│   ├── home_page.dart           # Home/Search screen
│   ├── weather_details_page.dart # Weather details screen
│   ├── favorites_page.dart      # Favorites screen
│   └── settings_page.dart       # Settings screen
├── services/
│   ├── api_service.dart         # OpenWeatherMap API integration
│   ├── storage_service.dart     # Local storage operations
│   └── weather_provider.dart    # State management provider
└── main.dart                    # App entry point
```

## Setup Instructions

### Prerequisites

1. **Flutter SDK**: Ensure Flutter is installed (version 3.0.0 or higher)
   ```bash
   flutter --version
   ```

2. **OpenWeatherMap API Key**: 
   - Sign up at [OpenWeatherMap](https://openweathermap.org/api)
   - Get your free API key from the dashboard
   - Free tier allows 60 calls/minute

### Installation Steps

1. **Clone or download the project**
   ```bash
   cd weather_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   
   Open `lib/config/api_config.dart` and replace `YOUR_API_KEY_HERE` with your actual OpenWeatherMap API key:
   
   ```dart
   static const String apiKey = 'your_actual_api_key_here';
   ```
   
   ⚠️ **Important**: This file is already in `.gitignore` to prevent committing your API key to version control.

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Android

To build an APK:

```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

### Building for iOS (macOS only)

```bash
flutter build ios --release
```

## API Usage

The app uses the OpenWeatherMap Current Weather Data API:

- **Endpoint**: `https://api.openweathermap.org/data/2.5/weather`
- **Method**: GET
- **Parameters**:
  - `q`: City name (e.g., "London", "New York")
  - `appid`: Your API key
  - `units`: `metric` (for °C) or `imperial` (for °F)

### Example API Call

```
https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY&units=metric
```

## Error Handling

The app handles various error scenarios:

- ✅ **No Internet Connection**: Shows user-friendly error message
- ✅ **Invalid City Name**: Displays "City not found" error
- ✅ **Invalid API Key**: Shows API key error message
- ✅ **API Errors**: Handles HTTP status codes (401, 404, etc.)
- ✅ **Loading States**: Shows loading indicators during API calls

## State Management

The app uses **Provider** for state management:

- `WeatherProvider`: Manages weather data, favorites, and settings
- Reactive UI updates when state changes
- Persistent storage for favorites and preferences

## Local Storage

The app uses **SharedPreferences** to store:

- Favorite cities list
- Temperature unit preference (metric/imperial)
- Search history (last 10 searches)

## Screenshots

### Home Screen
- Search bar with city name input
- Recent searches list
- Navigation to favorites and settings

### Weather Details Screen
- Large temperature display
- Weather icon
- Detailed information cards
- Favorite toggle button

### Favorites Screen
- List of saved cities
- Quick access to weather details
- Remove favorite option

### Settings Screen
- Temperature unit selection
- App information

## Features Implementation

### ✅ Completed Features

- [x] Multi-page navigation
- [x] City search functionality
- [x] Weather details display
- [x] Favorite cities management
- [x] Temperature unit settings
- [x] Search history
- [x] Error handling
- [x] Loading indicators
- [x] Local storage persistence
- [x] Clean UI design
- [x] Weather icons from API

### 🔄 Optional Features (Not Implemented)

- [ ] GPS location-based weather
- [ ] Language selector
- [ ] Dark mode theme
- [ ] Weather forecasts
- [ ] Multiple city comparison

## Troubleshooting

### Common Issues

1. **API Key Error (401)**
   - Verify your API key in `lib/config/api_config.dart`
   - Ensure the API key is active in OpenWeatherMap dashboard

2. **City Not Found (404)**
   - Check spelling of city name
   - Try using format: "City, Country" (e.g., "London, UK")

3. **No Internet Connection**
   - Ensure device has internet connectivity
   - Check API endpoint accessibility

4. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Ensure Flutter SDK is up to date

## License

This project is created for educational purposes as part of a Flutter development assignment.

## Credits

- **Weather Data**: [OpenWeatherMap](https://openweathermap.org/)
- **Icons**: Material Design Icons
- **Framework**: Flutter

## Contact

For issues or questions, please refer to the project repository.

---

**Note**: Remember to keep your API key secure and never commit it to version control. The `api_config.dart` file is already included in `.gitignore`.
