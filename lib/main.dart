import 'package:flutter/material.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import 'package:melon_metrics/providers/weather_provider.dart';
import 'package:melon_metrics/views/melon_metrics_app.dart';
import 'package:melon_metrics/models/inherited_virtual_pet_game_wrapper.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    InheritedVirtualPetGameWrapper(
      virtualPetGame: VirtualPetGame(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HealthProvider()),
          ChangeNotifierProvider(create: (context) => GoalProvider()),
          ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MelonMetricsApp(), // Your home app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
    );
  }
}
