import 'package:flutter/foundation.dart';
import '../models/app_state.dart';
import '../models/weather_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

/// Weather Provider
///
/// State management for weather data using Provider pattern
class WeatherProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  AppState _state = AppState();

  AppState get state => _state;

  WeatherModel? get currentWeather => _state.currentWeather;
  bool get isLoading => _state.isLoading;
  String? get error => _state.error;
  List<String> get favoriteCities => _state.favoriteCities;
  String get temperatureUnit => _state.temperatureUnit;

  WeatherProvider() {
    _initialize();
  }

  /// Initialize provider - load saved preferences
  Future<void> _initialize() async {
    final unit = await _storageService.getTemperatureUnit();
    final favorites = await _storageService.getFavoriteCities();

    _state = _state.copyWith(
      temperatureUnit: unit,
      favoriteCities: favorites,
    );
    notifyListeners();
  }

  /// Fetch weather by city name
  Future<void> fetchWeatherByCity(String cityName) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final weather = await _apiService.getWeatherByCityName(
        cityName,
        _state.temperatureUnit,
      );

      // Add to search history
      await _storageService.addToSearchHistory(cityName);

      _state = _state.copyWith(
        currentWeather: weather,
        isLoading: false,
        error: null,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      notifyListeners();
    }
  }

  /// Toggle favorite status for a city
  Future<void> toggleFavorite(String cityName) async {
    final isFavorite = await _storageService.isFavoriteCity(cityName);

    if (isFavorite) {
      await _storageService.removeFavoriteCity(cityName);
    } else {
      await _storageService.addFavoriteCity(cityName);
    }

    final favorites = await _storageService.getFavoriteCities();
    _state = _state.copyWith(favoriteCities: favorites);
    notifyListeners();
  }

  /// Check if a city is favorite
  Future<bool> isFavorite(String cityName) async {
    return await _storageService.isFavoriteCity(cityName);
  }

  /// Set temperature unit
  Future<void> setTemperatureUnit(String unit) async {
    await _storageService.setTemperatureUnit(unit);
    _state = _state.copyWith(temperatureUnit: unit);

    // If there's current weather, refetch with new unit
    if (_state.currentWeather != null) {
      await fetchWeatherByCity(_state.currentWeather!.cityName);
    }

    notifyListeners();
  }

  /// Load favorites from storage
  Future<void> loadFavorites() async {
    final favorites = await _storageService.getFavoriteCities();
    _state = _state.copyWith(favoriteCities: favorites);
    notifyListeners();
  }

  /// Get search history
  Future<List<String>> getSearchHistory() async {
    return await _storageService.getSearchHistory();
  }

  /// Clear error
  void clearError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }
}
