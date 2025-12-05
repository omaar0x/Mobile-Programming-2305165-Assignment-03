import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/weather_model.dart';

/// API Service
///
/// Handles all API calls to OpenWeatherMap
class ApiService {
  /// Fetch weather data by city name
  ///
  /// [cityName] - Name of the city to search for
  /// [unit] - Temperature unit: 'metric' for °C, 'imperial' for °F
  ///
  /// Returns WeatherModel on success, throws exception on error
  Future<WeatherModel> getWeatherByCityName(
    String cityName,
    String unit,
  ) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/weather?q=$cityName&appid=${ApiConfig.apiKey}&units=$unit',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the city name.');
      } else if (response.statusCode == 401) {
        throw Exception(
            'Invalid API key. Please check your API configuration.');
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Fetch weather data by coordinates (optional feature)
  ///
  /// [lat] - Latitude
  /// [lon] - Longitude
  /// [unit] - Temperature unit: 'metric' for °C, 'imperial' for °F
  Future<WeatherModel> getWeatherByCoordinates(
    double lat,
    double lon,
    String unit,
  ) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/weather?lat=$lat&lon=$lon&appid=${ApiConfig.apiKey}&units=$unit',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception(
            'Invalid API key. Please check your API configuration.');
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
