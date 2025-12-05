import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/weather_provider.dart';

/// Weather Details Page
///
/// Displays detailed weather information for a selected city
class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  String _formatTime(int timestamp, int timezone) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      (timestamp + timezone) * 1000,
      isUtc: true,
    );
    return DateFormat('HH:mm').format(dateTime);
  }

  String _getLocalTime(int timezone) {
    final now = DateTime.now().toUtc();
    final localTime = now.add(Duration(seconds: timezone));
    return DateFormat('HH:mm:ss').format(localTime);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final weather = provider.currentWeather;
    final unit = provider.temperatureUnit;
    final isMetric = unit == 'metric';
    final tempUnit = isMetric ? '°C' : '°F';
    final speedUnit = isMetric ? 'm/s' : 'mph';

    if (weather == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Weather Details')),
        body: const Center(
          child: Text('No weather data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName),
        actions: [
          FutureBuilder<bool>(
            future: provider.isFavorite(weather.cityName),
            builder: (context, snapshot) {
              final isFavorite = snapshot.data ?? false;
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  provider.toggleFavorite(weather.cityName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Removed from favorites'
                            : 'Added to favorites',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Weather Icon and Temperature
            Image.network(
              weather.iconUrl,
              width: 120,
              height: 120,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.wb_sunny, size: 120);
              },
            ),
            const SizedBox(height: 16),
            Text(
              '${weather.temperature.toStringAsFixed(1)}$tempUnit',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              weather.description.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // Weather Details Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'Feels like',
                      '${weather.feelsLike.toStringAsFixed(1)}$tempUnit',
                      Icons.thermostat,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      'Humidity',
                      '${weather.humidity}%',
                      Icons.water_drop,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      'Wind Speed',
                      '${weather.windSpeed.toStringAsFixed(1)} $speedUnit',
                      Icons.air,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      'Sunrise',
                      _formatTime(weather.sunrise, weather.timezone),
                      Icons.wb_sunny,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      'Sunset',
                      _formatTime(weather.sunset, weather.timezone),
                      Icons.nightlight_round,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      'Local Time',
                      _getLocalTime(weather.timezone),
                      Icons.access_time,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      'Country',
                      weather.country,
                      Icons.flag,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
