import 'package:flutter/material.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HealthProvider(),
    child: const MainApp(),
  ));
}

void getHealthData(BuildContext context) async {
  HealthProvider healthProvider =
      Provider.of<HealthProvider>(context, listen: false);
  await healthProvider.requestPermission();
  await healthProvider.fetchCalories();
  await healthProvider.fetchSleepHours();
  await healthProvider.fetchSteps();
  print('Calories burned: ${healthProvider.caloriesBurned}');
  print('Sleep hours: ${healthProvider.sleepHours}');
  print('Steps: ${healthProvider.steps}');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => getHealthData(context),
            child: const Text('Get Health Data'),
          ),
        ),
      ),
    );
  }
}
