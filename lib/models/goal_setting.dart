import 'package:isar/isar.dart';
part 'goal_setting.g.dart';

// Class to represent a user's new entry for health goals.
// Essentially serves to wrap 3 fields - sleep, steps, and calories -
// together.
@collection
class GoalSetting {
  // ID for Isar to track
  Id? id;
  final int sleepHours;
  final int steps;
  final int calories;

  /// factory constructor that creates an entry from a text entry
  /// Parameters
  /// - sleepHours: new goal for how much sleep user aims for
  /// - steps: steps user aims for
  /// - calories: goal calories to burn
  factory GoalSetting.fromText(
      {int sleepHours = 0, int steps = 0, int calories = 0}) {
    return GoalSetting(
        sleepHours: sleepHours, steps: steps, calories: calories);
  }

  /// Creates a Goal setting entry
  GoalSetting(
      {required this.sleepHours, required this.steps, required this.calories});
}
