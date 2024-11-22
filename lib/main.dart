import 'package:flutter/material.dart';
import 'package:melon_metrics/views/settings_views.dart'; // Replace with the correct path to your file
import 'package:melon_metrics/models/goal_setting.dart'; // Replace with the correct path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings View Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestSettingsView(),
    );
  }
}

class TestSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final testGoalSetting = GoalSetting(sleep: 7, steps: 10000, screenTime: 120);

    return SettingsViews(entry: testGoalSetting);
  }
}
