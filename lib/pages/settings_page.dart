import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

/// Settings Screen
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
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Temperature Unit Section
              const Text(
                'Temperature Unit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    RadioListTile<bool>(
                      title: const Text('Celsius (°C)'),
                      subtitle: const Text('Metric system'),
                      value: true,
                      groupValue: provider.isCelsius,
                      onChanged: (value) {
                        if (value != null) {
                          provider.setTemperatureUnit(value);
                        }
                      },
                    ),
                    const Divider(height: 1),
                    RadioListTile<bool>(
                      title: const Text('Fahrenheit (°F)'),
                      subtitle: const Text('Imperial system'),
                      value: false,
                      groupValue: provider.isCelsius,
                      onChanged: (value) {
                        if (value != null) {
                          provider.setTemperatureUnit(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // App Information Section
              const Text(
                'App Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Version'),
                      trailing: Text('1.0.0'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.api),
                      title: const Text('Weather Data'),
                      subtitle: const Text('OpenWeatherMap'),
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () {
                          // Could open OpenWeatherMap website
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

