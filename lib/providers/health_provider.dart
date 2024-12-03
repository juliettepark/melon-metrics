import 'dart:async';

import 'package:flame/components.dart' as flame; // import as alias to not confuse the Timer
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:provider/provider.dart';

class HealthProvider extends flame.Component with flame.HasGameRef<VirtualPetGame>, ChangeNotifier {
  double _caloriesBurned = 0.0;
  bool _isPermissionGranted = false;
  double _sleepHours = 0.0;
  int _steps = 0;
  Timer? _timer;
  flame.Timer? animateTimer;
  double _wellbeingScore = 0.0;

  int _goalSleepHours = 8;
  int _goalSteps = 10000;
  int _goalCalories = 2000;

  double get caloriesBurned => _caloriesBurned;
  bool get isPermissionGranted => _isPermissionGranted;
  double get sleepHours => _sleepHours;
  int get steps => _steps;
  double get wellbeingScore => _wellbeingScore;

  HealthProvider() {
    requestPermission();
    _startAutoUpdate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Starts the timer to auto-update the health data.
  void _startAutoUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      updateHealthData();
    });
    animateTimer = flame.Timer(
      1,
      onTick: () => gameRef.virtualPetData.walkCycle.value -= 1,
      repeat: true,
    );
  }

  /// Updates the health data.
  Future<void> updateHealthData() async {
    await fetchCalories();
    await fetchSleepHours();
    await fetchSteps();
    calculateWellbeingScore();
    notifyListeners();
  }

  @override
  void update(double dt) {
    if (gameRef.virtualPetData.walkCycle.value <= 0) {
      print("-----");
      print(_wellbeingScore);
      print(_caloriesBurned);
      print(_sleepHours);
      print(_steps);
      if (_wellbeingScore >= 66) {
        gameRef.virtualPetData.healthState.value = 2;
      } else if (_wellbeingScore < 33) {
        gameRef.virtualPetData.healthState.value = 0;
      } else {
        gameRef.virtualPetData.healthState.value = 1;
      }
      gameRef.virtualPetData.walkCycle.value = 16;
    } else {
      animateTimer?.update(dt);
    }
  }

  /// Request permission to access health data.
  Future<void> requestPermission() async {
    Health().configure();

    bool requested = await Health().requestAuthorization([
      HealthDataType.ACTIVE_ENERGY_BURNED,
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

  /// Calculates the wellbeing score based on calories burned, sleep hours, and steps.
  ///
  /// Returns:
  /// - The calculated wellbeing score on a 100 scale.
  void calculateWellbeingScore() {
    double score = 0;
    int count = 0;
    if (_caloriesBurned > 0) {
      score += (_caloriesBurned / _goalCalories) * 100;
      count++;
    }

    if (_sleepHours > 0) {
      score += (_sleepHours / _goalSleepHours) * 100;
      count++;
    }

    if (_steps > 0) {
      score += (_steps / _goalSteps) * 100;
      count++;
    }

    _wellbeingScore = count > 0 ? score / count : 0;
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

    _steps = await Health().getTotalStepsInInterval(midnight, now) ?? 0;
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

  /// Updates the current goals from the goal provider.
  ///
  /// Parameters:
  /// - context: The build context.
  void updateGoals(BuildContext context) {
    GoalProvider goalProvider =
        Provider.of<GoalProvider>(context, listen: false);
    _goalSleepHours = goalProvider.sleepHours;
    _goalSteps = goalProvider.steps;
    _goalCalories = goalProvider.calories;
  }
}
