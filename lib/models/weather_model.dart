/// Weather Model - Represents weather data from OpenWeatherMap API
class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;
  final int sunrise;
  final int sunset;
  final int timezone; // Timezone offset in seconds

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
  });

  /// Factory constructor to create WeatherModel from JSON
  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    return WeatherModel(
      cityName: cityName,
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
      sunrise: json['sys']['sunrise'] as int,
      sunset: json['sys']['sunset'] as int,
      timezone: json['timezone'] as int,
    );
  }

  /// Get weather icon URL
  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  /// Convert temperature based on unit
  double getTemperatureInUnit(bool isCelsius) {
    if (isCelsius) {
      return temperature - 273.15; // Convert from Kelvin to Celsius
    } else {
      return (temperature - 273.15) * 9 / 5 + 32; // Convert from Kelvin to Fahrenheit
    }
  }

  /// Convert feels like temperature based on unit
  double getFeelsLikeInUnit(bool isCelsius) {
    if (isCelsius) {
      return feelsLike - 273.15;
    } else {
      return (feelsLike - 273.15) * 9 / 5 + 32;
    }
  }

  /// Get wind speed in appropriate unit
  double getWindSpeedInUnit(bool isMetric) {
    if (isMetric) {
      return windSpeed * 3.6; // Convert m/s to km/h
    } else {
      return windSpeed * 2.237; // Convert m/s to mph
    }
  }
}

