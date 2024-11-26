import 'package:flutter/material.dart';

/// A provider class for managing goals, extending ChangeNotifier to allow listeners to be notified of changes.
class GoalProvider extends ChangeNotifier {

  // goal hours of sleep
  int sleep = 0;

  // goal number of steps
  int steps = 0;

  // goal hours of screen time
  int screenTime = 0;

  /// Updates the current goals for main page
  /// 
  /// Parameters: 
  ///     -newSleep: new sleep goal
  ///     -newSteps: new step goal
  ///     -newScreenTime: new screen time goal
  void updateGoals(int newSleep, int newSteps, int newScreenTime) {
    sleep = newSleep;
    newSteps = steps;
    screenTime = newScreenTime;
    notifyListeners();
  }
}
