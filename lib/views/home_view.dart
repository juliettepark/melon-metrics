import 'package:flutter/material.dart';
import 'package:melon_metrics/views/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void getHealthData(BuildContext context) async {
    HealthProvider healthProvider =
        Provider.of<HealthProvider>(context, listen: false);
    await healthProvider.updateHealthData();
    print('Calories burned: ${healthProvider.caloriesBurned}');
    print('Sleep hours: ${healthProvider.sleepHours}');
    print('Steps: ${healthProvider.steps}');
    print('Wellbeing score: ${healthProvider.wellbeingScore}');
  }

  @override
  Widget build(BuildContext context) {
    // return const Text('This is Home View');
    return 
      Consumer2<HealthProvider, GoalProvider>(
      builder: (context, healthProvider, goalProvider, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("Sleep: ${goalProvider.sleep.toString()}, \n Screen time ${goalProvider.screenTime.toString()} \n Steps: ${goalProvider.steps.toString()} \n"),
                Text("Sleep: ${healthProvider.sleepHours.toString()}, \n Steps ${healthProvider.steps.toString()} \n Calories burned: ${healthProvider.caloriesBurned.toString()} \n"),
                // LinearProgressIndicator(
                //   value: 3/5,
                //   backgroundColor: Colors.grey[300],
                //   color: Colors.blue,
                //   minHeight: 100,
                // ),
                ProgressBar(barIcon: Icons.night_shelter, goal: 5.0, actual: 3.0),
                ElevatedButton(
                  onPressed: () => getHealthData(context),
                  child: const Text('Refresh Health Data'),
                ),
            ],
          ),
        );
      }

      // Consumer<GoalProvider>(
      // builder: (context, goalProvider, child) {
      //   return (
      //     Text("Sleep: ${goalProvider.sleep.toString()}")
      //   );
      // }

    );
  }
}