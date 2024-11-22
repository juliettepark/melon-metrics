

class GoalSetting {

  // hours of sleep
  final int sleep;

  // number of steps
  final int steps;

  // screen time
  final int screenTime;

  /// factory constructor that creates an entry from a text entry
  factory GoalSetting.fromText({int sleep = 0, int steps = 0, int screenTime = 0}) {
    return GoalSetting(
        sleep: sleep,
        steps: steps,
        screenTime: screenTime);
  }

  /// Creates a Goal setting entry
  GoalSetting(
      {required this.sleep,
       required this.steps,
       required this.screenTime});

}