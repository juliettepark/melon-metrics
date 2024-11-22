import 'package:flutter/material.dart';
import 'package:melon_metrics/weather_conditions.dart';

/// Provides weather data to the UI.
class WeatherProvider extends ChangeNotifier {
  int tempInfahrenheit = 0;
  WeatherCondition condition = WeatherCondition.gloomy;
  String error = '';
  bool hasWeatherData = false;

  /// Updates the weather data with the new temperature and condition.
  ///
  /// Parameters:
  /// - newTempfahrenheit: The new temperature in Fahrenheit.
  /// - newCondition: The new weather condition.
  void updateWeather(int newTempfahrenheit, WeatherCondition newCondition) {
    tempInfahrenheit = newTempfahrenheit;
    condition = newCondition;
    hasWeatherData = true; // stop showing the loading spinner
    notifyListeners(); // notify the UI to update
  }

  /// Updates the error message.
  ///
  /// Parameters:
  /// - newError: The new error message.
  void setError(String newError) {
    error = newError;
    hasWeatherData = false;
    notifyListeners(); // notify the UI to update
  }
}
