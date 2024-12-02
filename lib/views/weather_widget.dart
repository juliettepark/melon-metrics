import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melon_metrics/helpers/weather_checker.dart';
import 'package:melon_metrics/providers/weather_provider.dart';
import 'package:melon_metrics/weather_conditions.dart';
import 'package:provider/provider.dart';

/// A widget that displays the weather condition with exercise suggestions.
class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late final WeatherChecker _weatherChecker;
  Timer? _timer;

  /// Fetches the weather and updates the UI.
  void _fetchWeather() async {
    await _weatherChecker.fetchAndUpdateCurrentSeattleWeather();
  }

  /// Starts the timer to update the weather every minute.
  void _startWeatherUpdateTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
      final periodicWeatherCheck = WeatherChecker(weatherProvider);
      periodicWeatherCheck.fetchAndUpdateCurrentSeattleWeather();
      // _fetchWeather();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    _weatherChecker = WeatherChecker(weatherProvider);

    _fetchWeather();
    _startWeatherUpdateTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
      if (weatherProvider.error != '') {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Center(
            child: Text(weatherProvider.error),
          ),
        );
      }

      if (!weatherProvider.hasWeatherData) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: const Center(
            child: CircularProgressIndicator(), // loading spinner
          ),
        );
      }

      final condition = weatherProvider.condition;

      final iconToShow = switch (condition) {
        WeatherCondition.gloomy => Icons.cloud,
        WeatherCondition.rainy => Icons.umbrella,
        WeatherCondition.sunny => Icons.wb_sunny,
      };
      final textToShow = switch (condition) {
        WeatherCondition.gloomy => 'It is gloomy outside! \n Do some wall sits!',
        WeatherCondition.rainy =>
          'It is raining outside! \n Find a gym to workout!',
        WeatherCondition.sunny =>
          'It is sunny outside! \n Let\'s do some outdoor \n activities!',
      };

      return Center(
        child: SizedBox(
          height: 100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            shadowColor: Colors.grey,
            color: Theme.of(context).colorScheme.surfaceTint,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textToShow,
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(iconToShow, size: 30, color: Theme.of(context).colorScheme.onPrimary,),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
