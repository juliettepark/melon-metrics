import 'package:flutter/material.dart';
import 'package:health/health.dart';

class HealthProvider with ChangeNotifier {
  double _caloriesBurned = 0.0;
  bool _isPermissionGranted = false;
  double _sleepHours = 0.0;
  int? _steps = 0;

  double get caloriesBurned => _caloriesBurned;
  bool get isPermissionGranted => _isPermissionGranted;
  double get sleepHours => _sleepHours;
  int? get steps => _steps;

  /// Request permission to access health data.
  Future<void> requestPermission() async {
    Health().configure();

    bool requested = await Health().requestAuthorization([
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BODY_TEMPERATURE,
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_LIGHT,
      HealthDataType.SLEEP_REM,
      HealthDataType.STEPS,
    ]);

    _isPermissionGranted = requested;
    notifyListeners();
  }

  /// Gets the calories burned for the current day.
  Future<void> fetchCalories() async {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day);

    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
      startTime: midnight,
      endTime: now,
      types: [HealthDataType.ACTIVE_ENERGY_BURNED],
    );

    _caloriesBurned = _sumHealthDataPoints(healthData);
    notifyListeners(); // Notify listeners when data changes
  }

  /// Gets the sleep hours for the current day.
  Future<void> fetchSleepHours() async {
    double sleepHours = await _getSleepFromWatch();
    if (sleepHours <= 0) {
      sleepHours = await getSleepFromPhone();
    }

    _sleepHours = sleepHours;
    notifyListeners();
  }

  Future<double> _getSleepFromWatch() async {
    DateTime now = DateTime.now();

    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
      types: [
        HealthDataType.SLEEP_AWAKE,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_REM,
      ],
    );

    return _sumHealthDataPoints(healthData);
  }

  Future<double> getSleepFromPhone() async {
    DateTime now = DateTime.now();

    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
      types: [HealthDataType.SLEEP_IN_BED],
    );

    return _sumHealthDataPoints(healthData);
  }

  /// Gets the steps for the current day.
  Future<void> fetchSteps() async {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day);

    _steps = await Health().getTotalStepsInInterval(midnight, now);
    notifyListeners();
  }

  /// Sums the numeric values of the health data points.
  ///
  /// Parameters:
  /// - healthData: A list of health data points.
  ///
  /// Returns:
  /// - The sum of the numeric values of the health data points.
  double _sumHealthDataPoints(List<HealthDataPoint> healthData) {
    double sum = 0;
    for (var data in healthData) {
      NumericHealthValue value = data.value as NumericHealthValue;
      sum += value.numericValue;
    }
    return sum;
  }
}
