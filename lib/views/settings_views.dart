import 'package:flutter/material.dart';
import 'package:melon_metrics/models/goal_setting.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import 'package:provider/provider.dart';

class SettingsViews extends StatefulWidget {
  final GoalSetting entry;

  const SettingsViews({super.key, required this.entry});

  @override
  State<SettingsViews> createState() => _SettingsViewsState();
}

// Settings view page to allow users to edit their health goals
class _SettingsViewsState extends State<SettingsViews> {
  late int currentSleep;
  late int currentSteps;
  late int currentCalories;

  // Temporary state to record changes
  @override
  void initState() {
    super.initState();
    currentSleep = widget.entry.sleepHours;
    currentSteps = widget.entry.steps;
    currentCalories = widget.entry.calories;
  }

  // Display input fields for each health metric and
  // a save button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Settings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(color: Colors.grey, width: 1), // Add the bar here
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sleep input field
            Semantics(
              label: 'Edit goal for sleep hours. Current goal: $currentSleep',
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center align the row
                children: [
                  const Text('Sleep: ', style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 150, // Set the desired width of the field
                    child: TextFormField(
                      initialValue: currentSleep.toString(),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          currentSleep = int.tryParse(value) ?? currentSleep;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Steps input field
            Semantics(
              label: 'Edit goal for daily steps. Current goal: $currentSteps',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Steps: ', style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      initialValue: currentSteps.toString(),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          currentSteps = int.tryParse(value) ?? currentSteps;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Calories input field
            Semantics(
              label:
                  'Edit goal for daily calories burned. Current goal: $currentCalories',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Calories: ', style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      initialValue: currentCalories.toString(),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          currentCalories =
                              int.tryParse(value) ?? currentCalories;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Save Button to record new settings
            Semantics(
              label: 'Save new health goal settings',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(116, 84, 106, 1),
                    foregroundColor: const Color.fromRGBO(246, 200, 177, 1)),
                onPressed: () {
                  // Update goals using the provider
                  final goals = GoalSetting(
                      sleepHours: currentSleep,
                      steps: currentSteps,
                      calories: currentCalories);
                  Provider.of<GoalProvider>(context, listen: false)
                      .updateGoals(goals);
                  Provider.of<HealthProvider>(context, listen: false)
                      .updateGoals(goals);

                  // unfocus the text fields so the keyboard will not cover the navigation bar
                  FocusScope.of(context).unfocus();
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
