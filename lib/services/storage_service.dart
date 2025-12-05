import 'package:shared_preferences/shared_preferences.dart';

/// Storage Service
///
/// Handles local storage operations for favorites and settings
class StorageService {
  static const String _favoritesKey = 'favorite_cities';
  static const String _temperatureUnitKey = 'temperature_unit';
  static const String _searchHistoryKey = 'search_history';

  /// Get favorite cities list
  Future<List<String>> getFavoriteCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  /// Add a city to favorites
  Future<bool> addFavoriteCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteCities();

    if (!favorites.contains(cityName)) {
      favorites.add(cityName);
      return await prefs.setStringList(_favoritesKey, favorites);
    }
    return false;
  }

  /// Remove a city from favorites
  Future<bool> removeFavoriteCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteCities();
    favorites.remove(cityName);
    return await prefs.setStringList(_favoritesKey, favorites);
  }

  /// Check if a city is in favorites
  Future<bool> isFavoriteCity(String cityName) async {
    final favorites = await getFavoriteCities();
    return favorites.contains(cityName);
  }

  /// Get temperature unit preference
  /// Returns 'metric' for °C or 'imperial' for °F
  Future<String> getTemperatureUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_temperatureUnitKey) ?? 'metric';
  }

  /// Set temperature unit preference
  Future<bool> setTemperatureUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_temperatureUnitKey, unit);
  }

  /// Get search history
  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  /// Add to search history
  Future<bool> addToSearchHistory(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();

    // Remove if already exists to avoid duplicates
    history.remove(cityName);
    // Add to beginning
    history.insert(0, cityName);

    // Keep only last 10 searches
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }

    return await prefs.setStringList(_searchHistoryKey, history);
  }

  /// Clear search history
  Future<bool> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_searchHistoryKey);
  }
}
