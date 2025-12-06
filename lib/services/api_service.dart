import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/weather_model.dart';

/// API Service for OpenWeatherMap Current Weather API
class ApiService {
  /// Fetch weather data by city name
  /// Returns WeatherModel on success, throws exception on error
  Future<WeatherModel> getWeatherByCityName(String cityName) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/weather?q=$cityName&appid=${ApiConfig.apiKey}',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData, cityName);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your API configuration.');
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the city name.');
      } else if (response.statusCode == 429) {
        throw Exception('API rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
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
  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon) async {
    try {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/weather?lat=$lat&lon=$lon&appid=${ApiConfig.apiKey}',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final cityName = jsonData['name'] as String;
        return WeatherModel.fromJson(jsonData, cityName);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your API configuration.');
      } else if (response.statusCode == 404) {
        throw Exception('Location not found.');
      } else {
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
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

