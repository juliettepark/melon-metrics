import 'package:flutter/material.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';

// Represents the set of progress bars that indicate to the user
// their progress towards each of their health goals.
class ProgressBar extends StatelessWidget {
  final HealthProvider healthProvider;
  final GoalProvider goalProvider;
  const ProgressBar(
      {super.key, required this.healthProvider, required this.goalProvider});

  @override
  Widget build(BuildContext context) {
    // Create the 3 progress bars indicating progress towards
    // Sleep, Steps, and Calories burned goals
    return Column(
      children: [
        makeSingleBar(
            barIcon: Icons.nightlight,
            goal: goalProvider.sleepHours.toDouble(),
            actual: healthProvider.sleepHours.toDouble(),
            fillBar: const Color.fromRGBO(
              116,
              84,
              106,
              1,
            ),
            iconlabel: 'Sleep hours'),
        makeSingleBar(
            barIcon: Icons.directions_walk_rounded,
            goal: goalProvider.steps.toDouble(),
            actual: healthProvider.steps.toDouble(),
            fillBar: Theme.of(context).colorScheme.surfaceTint,
            iconlabel: 'Steps walked'),
        makeSingleBar(
            barIcon: Icons.fireplace_outlined,
            goal: goalProvider.calories.toDouble(),
            actual: healthProvider.caloriesBurned,
            fillBar: const Color.fromRGBO(246, 126, 125, 1),
            iconlabel: 'Calories Burned'),
      ],
    );
  }

  // Create a single Progress Bar showing progress towards one
  // of the health goals.
  // Bars will not go past the maximum (the user defined goal)
  // param:
  // - barIcon: Icon to display next to progress bar
  // - goal: What the maximum metric (user's goal) is
  // - actual: The value for how many steps, hours of sleep, or
  //           calories burned the user actually got
  // - fillBar: Color to fill progress bar with
  // - iconlabel: Description of what kind of health
  //              metric this bar represents
  Widget makeSingleBar(
      {required IconData barIcon,
      required double goal,
      required double actual,
      required Color fillBar,
      required String iconlabel}) {
    // Calculate the progress as a percentage
    double progress;

    // Make sure the progress doesn't exceed 100% (i.e., 1.0)
    print('Goal: ${goal}, Actual $actual for $iconlabel');
    if (goal != 0.0 && actual != 0.0) {
      progress = actual / goal;
    } else {
      progress = 0.0;
    }
    progress = progress > 1.0 ? 1.0 : progress;
    // progress = goal == 0 || actual == 0 ? 0 : progress;

    return Semantics(
      label: '$iconlabel is $progress out of $goal',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                barIcon,
                size: 30,
                semanticLabel: iconlabel,
              ),
            ),
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: fillBar,
                minHeight: 20,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            // Expanded(child: Padding(
            //   padding: const EdgeInsets.only( left: 8.0),
            //   child: Text('(${actual.toInt()} / ${goal.toInt()})'),
            // ))
          ],
        ),
      ),
    );
  }
}