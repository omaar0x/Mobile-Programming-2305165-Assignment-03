import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/weather_provider.dart';
import '../models/weather_model.dart';

/// Weather Details Screen
class WeatherDetailsPage extends StatefulWidget {
  final String cityName;

  const WeatherDetailsPage({super.key, required this.cityName});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
    _loadWeather();
  }

  Future<void> _checkFavorite() async {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    final isFav = await provider.isFavorite(widget.cityName);
    setState(() {
      _isFavorite = isFav;
    });
  }

  void _loadWeather() {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    provider.fetchWeatherByCity(widget.cityName);
  }

  Future<void> _toggleFavorite() async {
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    if (_isFavorite) {
      await provider.removeFavorite(widget.cityName);
    } else {
      await provider.addFavorite(widget.cityName);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite
            ? 'Removed from favorites'
            : 'Added to favorites'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String _formatTime(int timestamp, int timezone) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      (timestamp + timezone) * 1000,
      isUtc: true,
    );
    return DateFormat('HH:mm').format(dateTime);
  }

  String _formatLocalTime(int timezone) {
    final now = DateTime.now().toUtc();
    final localTime = now.add(Duration(seconds: timezone));
    return DateFormat('HH:mm').format(localTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      provider.errorMessage!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        provider.clearError();
                        _loadWeather();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final weather = provider.currentWeather;
          if (weather == null) {
            return const Center(
              child: Text('No weather data available'),
            );
          }

          final isCelsius = provider.isCelsius;
          final temp = weather.getTemperatureInUnit(isCelsius);
          final feelsLike = weather.getFeelsLikeInUnit(isCelsius);
          final windSpeed = weather.getWindSpeedInUnit(isCelsius);
          final windUnit = isCelsius ? 'km/h' : 'mph';

          return SingleChildScrollView(
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
                  '${temp.toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  weather.description.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),

                // Local Time
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Local Time'),
                    trailing: Text(
                      _formatLocalTime(weather.timezone),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Feels Like
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.thermostat),
                    title: const Text('Feels Like'),
                    trailing: Text(
                      '${feelsLike.toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Humidity
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.water_drop),
                    title: const Text('Humidity'),
                    trailing: Text(
                      '${weather.humidity}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Wind Speed
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.air),
                    title: const Text('Wind Speed'),
                    trailing: Text(
                      '${windSpeed.toStringAsFixed(1)} $windUnit',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sunrise
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.wb_sunny),
                    title: const Text('Sunrise'),
                    trailing: Text(
                      _formatTime(weather.sunrise, weather.timezone),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sunset
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.wb_twilight),
                    title: const Text('Sunset'),
                    trailing: Text(
                      _formatTime(weather.sunset, weather.timezone),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

