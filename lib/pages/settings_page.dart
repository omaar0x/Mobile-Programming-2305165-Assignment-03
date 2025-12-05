import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_provider.dart';

/// Settings Page
///
/// Allows users to configure app settings like temperature units
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          final currentUnit = provider.temperatureUnit;
          final isMetric = currentUnit == 'metric';

          return ListView(
            children: [
              // Temperature Unit Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Temperature Unit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RadioListTile<String>(
                title: const Text('Celsius (°C)'),
                subtitle: const Text('Metric system'),
                value: 'metric',
                groupValue: currentUnit,
                onChanged: (value) {
                  if (value != null) {
                    provider.setTemperatureUnit(value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Temperature unit changed to Celsius'),
                      ),
                    );
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Fahrenheit (°F)'),
                subtitle: const Text('Imperial system'),
                value: 'imperial',
                groupValue: currentUnit,
                onChanged: (value) {
                  if (value != null) {
                    provider.setTemperatureUnit(value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Temperature unit changed to Fahrenheit'),
                      ),
                    );
                  }
                },
              ),
              const Divider(),

              // App Information Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'App Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Version'),
                subtitle: Text('1.0.0'),
              ),
              const ListTile(
                leading: Icon(Icons.api),
                title: Text('Weather Data'),
                subtitle: Text('Powered by OpenWeatherMap'),
              ),
              const ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('About'),
                subtitle: Text(
                  'Multi-page Flutter weather application with real-time weather data, favorites, and customizable settings.',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
