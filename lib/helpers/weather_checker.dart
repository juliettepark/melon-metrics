import 'dart:convert';
import 'package:melon_metrics/providers/position_provider.dart';
import 'package:melon_metrics/providers/weather_provider.dart';
import 'package:http/http.dart' as http;
import 'package:melon_metrics/weather_conditions.dart';

//ignore_for_file: avoid_print

/// Fetches the current weather at Allen Center and updates the WeatherProvider.
///
/// Parameters:
/// - weatherProvider: The WeatherProvider to update with the new weather data.
/// - client: The HTTP client to use for fetching data. If not provided, a new
///   client will be created.
class WeatherChecker {
  final WeatherProvider weatherProvider;
  final PositionProvider positionProvider;
  final http.Client client;

  WeatherChecker(this.weatherProvider, this.positionProvider,
      [http.Client? client])
      : client = client ?? http.Client();

  /// Fetches the current weather at Allen Center and updates the
  /// WeatherProvider.
  ///
  /// Returns:
  /// - A Future that completes when the weather has been fetched and updated.
  Future<void> fetchAndUpdateCurrentSeattleWeather() async {
    try {
      final position = await positionProvider.determinePosition();
      final gridResponse = await client.get(Uri.parse(
          'https://api.weather.gov/points/${position.latitude},${position.longitude}'));
      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];
      if (forecastURL == null) {
        // do nothing
      } else {
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);
        final currentPeriod = weatherParsed['properties']?['periods']?[0];
        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];
          print(
              'Got the weather at ${DateTime.now()}. $temperature F and $shortForecast');
          if (temperature != null && shortForecast != null) {
            final condition = _shortForecastToCondition(shortForecast);
            weatherProvider.updateWeather(temperature, condition);
          }
        }
      }
    } catch (error) {
      // shows error message on the UI
      weatherProvider.setError('Error fetching weather: $error');
    } finally {
      client.close();
    }
  }

  /// Converts a short forecast to a weather condition enum.
  ///
  /// Parameters:
  /// - shortForecast: The short forecast to convert.
  ///
  /// Returns:
  /// - The weather condition enum.
  WeatherCondition _shortForecastToCondition(String shortForecast) {
    final lowercased = shortForecast.toLowerCase();
    if (lowercased.startsWith('rain')) return WeatherCondition.rainy;
    if (lowercased.startsWith('sun') || lowercased.startsWith('partly')) {
      return WeatherCondition.sunny;
    }
    return WeatherCondition.gloomy;
  }
}
