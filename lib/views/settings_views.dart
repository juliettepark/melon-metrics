import 'package:flutter/material.dart';
import 'package:melon_metrics/models/goal_setting.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:provider/provider.dart';

class SettingsViews extends StatefulWidget {
  final GoalSetting entry;

  const SettingsViews({super.key, required this.entry});

  @override
  State<SettingsViews> createState() => _SettingsViewsState();
}

class _SettingsViewsState extends State<SettingsViews> {
  late int currentSleep;
  late int currentSteps;
  late int currentScreenTime;

  @override
  void initState() {
    super.initState();
    currentSleep = widget.entry.sleep;
    currentSteps = widget.entry.steps;
    currentScreenTime = widget.entry.screenTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Setting'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Cancel',
          onPressed: () => Navigator.pop(context), // Navigate back to main page
        ),

        flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1), // Add the bar here
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center align the row
              children: [
                const Text('Sleep: ', style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 150, // Set the desired width of the field
                  child: TextFormField(
                    initialValue: currentSleep.toString(),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
            const SizedBox(height: 10),
            // Steps input field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Steps: ', style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    initialValue: currentSteps.toString(),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
            const SizedBox(height: 10),
            // Screen Time input field
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Screen Time: ', style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    initialValue: currentScreenTime.toString(),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        currentScreenTime = int.tryParse(value) ?? currentScreenTime;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Update goals using the provider
                Provider.of<GoalProvider>(context, listen: false).updateGoals(
                  currentSleep,
                  currentSteps,
                  currentScreenTime
                );
                Navigator.pop(context); // Optionally navigate back
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
