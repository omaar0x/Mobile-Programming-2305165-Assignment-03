import '../models/weather_model.dart';

/// App State Model
///
/// Represents the application state for weather data
class AppState {
  final WeatherModel? currentWeather;
  final bool isLoading;
  final String? error;
  final List<String> favoriteCities;
  final String temperatureUnit; // 'metric' or 'imperial'

  AppState({
    this.currentWeather,
    this.isLoading = false,
    this.error,
    this.favoriteCities = const [],
    this.temperatureUnit = 'metric',
  });

  /// Create a copy of the state with updated values
  AppState copyWith({
    WeatherModel? currentWeather,
    bool? isLoading,
    String? error,
    List<String>? favoriteCities,
    String? temperatureUnit,
  }) {
    return AppState(
      currentWeather: currentWeather ?? this.currentWeather,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      favoriteCities: favoriteCities ?? this.favoriteCities,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
    );
  }
}
