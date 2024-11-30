import 'package:isar/isar.dart';
part 'goal_setting.g.dart';

@collection
class GoalSetting {
  // ID for Isar to track
  Id? id;
  final int sleepHours;
  final int steps;
  final int calories;

  /// factory constructor that creates an entry from a text entry
  factory GoalSetting.fromText(
      {int sleepHours = 0, int steps = 0, int calories = 0}) {
    return GoalSetting(
        sleepHours: sleepHours, steps: steps, calories: calories);
  }

  /// Creates a Goal setting entry
  GoalSetting(
      {required this.sleepHours, required this.steps, required this.calories});
}
