import 'package:flutter/material.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import 'package:melon_metrics/providers/weather_provider.dart';
import 'package:melon_metrics/views/melon_metrics_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HealthProvider()),
        ChangeNotifierProvider(create: (context) => GoalProvider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider())
      ],
      child: const MainApp(),
      )
    );
}

void getHealthData(BuildContext context) async {
  HealthProvider healthProvider =
      Provider.of<HealthProvider>(context, listen: false);
  await healthProvider.updateHealthData();
  print('Calories burned: ${healthProvider.caloriesBurned}');
  print('Sleep hours: ${healthProvider.sleepHours}');
  print('Steps: ${healthProvider.steps}');
  print('Wellbeing score: ${healthProvider.wellbeingScore}');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      // Scaffold(
      //   body: Center(
      //     child: ElevatedButton(
      //       onPressed: () => getHealthData(context),
      //       child: const Text('Get Health Data'),
      //     ),
      //   ),
      // ),
      const MelonMetricsApp(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      
    );
  }
}