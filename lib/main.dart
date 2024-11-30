import 'package:flutter/material.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import 'package:melon_metrics/providers/weather_provider.dart';
import 'package:melon_metrics/views/melon_metrics_app.dart';
import 'package:melon_metrics/models/inherited_virtual_pet_game_wrapper.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:melon_metrics/models/goal_setting.dart';

void main() async {
  // Need to call this before using isar, if we haven't yet called runApp
  WidgetsFlutterBinding.ensureInitialized();
  // Path to sandbox where space is allocated for our app
  final dir = await getApplicationDocumentsDirectory();
  // Get a reference to the Isar database that lives in this sandbox
  // that will persist our data!
  final isar = await Isar.open([GoalSettingSchema], directory: dir.path);
  runApp(
    InheritedVirtualPetGameWrapper(
      virtualPetGame: VirtualPetGame(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HealthProvider()),
          ChangeNotifierProvider(create: (context) => GoalProvider(isar)),
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
