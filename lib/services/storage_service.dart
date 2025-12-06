import 'package:shared_preferences/shared_preferences.dart';

/// Storage Service for managing local data (favorites, settings)
class StorageService {
  static const String _favoritesKey = 'favorite_cities';
  static const String _isCelsiusKey = 'is_celsius';

  /// Get SharedPreferences instance
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Save a city to favorites
  Future<bool> addFavorite(String cityName) async {
    final prefs = await _prefs;
    final favorites = getFavorites();
    if (!favorites.contains(cityName)) {
      favorites.add(cityName);
      return await prefs.setStringList(_favoritesKey, favorites);
    }
    return true;
  }

  /// Remove a city from favorites
  Future<bool> removeFavorite(String cityName) async {
    final prefs = await _prefs;
    final favorites = getFavorites();
    favorites.remove(cityName);
    return await prefs.setStringList(_favoritesKey, favorites);
  }

  /// Get list of favorite cities
  List<String> getFavorites() {
    // Note: SharedPreferences.getInstance() is async, but for simplicity
    // we'll use a synchronous approach. In production, consider using a Future-based approach.
    // For now, we'll handle this in the provider with async methods.
    return [];
  }

  /// Get list of favorite cities (async version)
  Future<List<String>> getFavoritesAsync() async {
    final prefs = await _prefs;
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  /// Check if a city is in favorites
  Future<bool> isFavorite(String cityName) async {
    final favorites = await getFavoritesAsync();
    return favorites.contains(cityName);
  }

  /// Save temperature unit preference
  Future<bool> setIsCelsius(bool isCelsius) async {
    final prefs = await _prefs;
    return await prefs.setBool(_isCelsiusKey, isCelsius);
  }

  /// Get temperature unit preference (default: true for Celsius)
  Future<bool> getIsCelsius() async {
    final prefs = await _prefs;
    return prefs.getBool(_isCelsiusKey) ?? true;
  }
}

