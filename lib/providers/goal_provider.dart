import 'package:flutter/material.dart';

/// A provider class for managing goals, extending ChangeNotifier to allow listeners to be notified of changes.
class GoalProvider extends ChangeNotifier {
  int sleepHours = 0;
  int steps = 0;
  int calories = 0;

  /// Updates the current goals for main page
  ///
  /// Parameters:
  ///     -newSleep: new sleep goal
  ///     -newSteps: new step goal
  ///     -newScreenTime: new screen time goal
  void updateGoals(int newSleepHours, int newSteps, int newCalories) {
    sleepHours = newSleepHours;
    steps = newSteps;
    calories = newCalories;
    notifyListeners();
  }
}
