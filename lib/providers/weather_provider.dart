import 'package:flutter/foundation.dart';
import '../models/weather_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

/// Weather Provider for state management
class WeatherProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  WeatherModel? _currentWeather;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isCelsius = true;
  List<String> _favorites = [];

  WeatherModel? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isCelsius => _isCelsius;
  List<String> get favorites => _favorites;

  WeatherProvider() {
    _loadSettings();
    _loadFavorites();
  }

  /// Load settings from storage
  Future<void> _loadSettings() async {
    _isCelsius = await _storageService.getIsCelsius();
    notifyListeners();
  }

  /// Load favorites from storage
  Future<void> _loadFavorites() async {
    _favorites = await _storageService.getFavoritesAsync();
    notifyListeners();
  }

  /// Fetch weather by city name
  Future<void> fetchWeatherByCity(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentWeather = await _apiService.getWeatherByCityName(cityName);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _currentWeather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Toggle temperature unit
  Future<void> toggleTemperatureUnit() async {
    _isCelsius = !_isCelsius;
    await _storageService.setIsCelsius(_isCelsius);
    notifyListeners();
  }

  /// Set temperature unit
  Future<void> setTemperatureUnit(bool isCelsius) async {
    _isCelsius = isCelsius;
    await _storageService.setIsCelsius(_isCelsius);
    notifyListeners();
  }

  /// Add city to favorites
  Future<void> addFavorite(String cityName) async {
    await _storageService.addFavorite(cityName);
    await _loadFavorites();
  }

  /// Remove city from favorites
  Future<void> removeFavorite(String cityName) async {
    await _storageService.removeFavorite(cityName);
    await _loadFavorites();
  }

  /// Check if city is favorite
  Future<bool> isFavorite(String cityName) async {
    return await _storageService.isFavorite(cityName);
  }

  /// Reload favorites from storage
  Future<void> reloadFavorites() async {
    await _loadFavorites();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

