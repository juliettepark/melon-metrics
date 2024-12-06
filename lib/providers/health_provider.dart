import 'dart:async';

import 'package:flame/components.dart'
    as flame; // import as alias to not confuse the Timer
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:isar/isar.dart';
import 'package:melon_metrics/models/goal_setting.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart';

class HealthProvider extends flame.Component
    with flame.HasGameRef<VirtualPetGame>, ChangeNotifier {
  double _caloriesBurned = 0.0;
  bool _isPermissionGranted = false;
  double _sleepHours = 0.0;
  int _steps = 0;
  Timer? _timer;
  flame.Timer? animateTimer;
  double _wellbeingScore = 0.0;

  GoalSetting _goals = GoalSetting(sleepHours: 7, steps: 1000, calories: 100);

  double get caloriesBurned => _caloriesBurned;
  bool get isPermissionGranted => _isPermissionGranted;
  double get sleepHours => _sleepHours;
  int get steps => _steps;
  double get wellbeingScore => _wellbeingScore;

  HealthProvider(Isar? isar) {
    // TODO: make isar non-null; pass it in virtual_pet_name.dart
    if (isar != null) {
      List<GoalSetting> pastGoals = isar.goalSettings.where().findAllSync();
      if (pastGoals.isNotEmpty) {
        _goals = pastGoals.last;
      }
    }

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
    calculateWellbeingScore(_goals);
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
      if (getHealthCondition() == "Good") {
        print("GOOD");
        gameRef.virtualPetData.healthState.value = 2;
      } else if (getHealthCondition() == "Poor") {
        print("BAD");
        gameRef.virtualPetData.healthState.value = 0;
      } else {
        print("OK..." + getHealthCondition());
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
  void calculateWellbeingScore(GoalSetting goals) {
    print("IMPORTANT--------------");
    print(goals.calories);
    print(goals.sleepHours);
    print(goals.steps);
    double score = 0;
    int count = 0;
    if (_caloriesBurned > 0) {
      final caloriesScore = (_caloriesBurned / goals.calories) * 100;
      if (caloriesScore > 100) {
        score += 100;
      } else {
        score += caloriesScore;
      }
      count++;
    }

    if (_sleepHours > 0) {
      final sleepScore = (_sleepHours / goals.sleepHours) * 100;
      if (sleepScore > 100) {
        score += 100;
      } else {
        score += sleepScore;
      }
      count++;
    }

    if (_steps > 0) {
      final stepScore = (_steps / goals.steps) * 100;
      if (stepScore > 100) {
        score += 100;
      } else {
        score += stepScore;
      }
      count++;
    }

    double wellbeingScore = count > 0 ? score / count : 0;
    _wellbeingScore = wellbeingScore;
  }

  // Converts the well-being score into one of 3 states:
  // Good, Okay, Poor based on what "third" the score falls
  // into out of a maximum of 100
  String getHealthCondition() {
    String condition;
    print("MOST IMPORTANT $_wellbeingScore");
    if (_wellbeingScore >= 66) {
      condition = "Good";
    } else if (_wellbeingScore < 33) {
      condition = "Poor";
    } else {
      condition = "Okay";
    }
    return condition;
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
    double sleepMinutes = await _getSleepFromWatch();
    if (sleepMinutes <= 0) {
      sleepMinutes = await getSleepFromPhone();
    }

    _sleepHours = sleepMinutes / 60;
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

  /// Updates the current goals.
  ///
  /// Parameters:
  /// - goals: The new goals to be set.
  void updateGoals(GoalSetting goals) {
    _goals = goals;
    calculateWellbeingScore(goals);
    notifyListeners();
  }
}
