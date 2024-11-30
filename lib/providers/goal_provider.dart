import 'package:flutter/material.dart';
import 'package:melon_metrics/models/goal_setting.dart';
import 'package:isar/isar.dart';

/// A provider class for managing goals, extending ChangeNotifier to allow listeners to be notified of changes.
class GoalProvider extends ChangeNotifier {
  // int _sleepHours = 0;
  // int _steps = 0;
  // int _calories = 0;
  final Isar _isar;
  // If no settings have been configured before, will default to these
  GoalSetting goals = GoalSetting(sleepHours: 8, steps: 1000, calories: 200);

  GoalProvider(Isar isar): _isar = isar {
    List<GoalSetting> pastGoals = isar.goalSettings.where().findAllSync();
    if (pastGoals.isNotEmpty) {
      goals = pastGoals.last;
    }
  }

  int get sleepHours { return goals.sleepHours; }
  int get steps { return goals.steps; }
  int get calories { return goals.calories; }

  /// Updates the current goals for main page
  ///
  /// Parameters:
  ///     -newSleep: new sleep goal
  ///     -newSteps: new step goal
  ///     -newScreenTime: new screen time goal
  void updateGoals(int newSleepHours, int newSteps, int newCalories) async {
    goals = GoalSetting(sleepHours: newSleepHours, 
                        steps: newSteps, calories: 
                        newCalories);
    // sleepHours = newSleepHours;
    // steps = newSteps;
    // calories = newCalories;

    // also track in isar
    await _isar.writeTxn(() async {
      await _isar.goalSettings.put(goals); // insert & update
    });

    notifyListeners();
  }
}
