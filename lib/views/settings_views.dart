import 'package:flutter/material.dart';
import 'package:melon_metrics/models/goal_setting.dart';

class SettingsViews extends StatefulWidget {
  final GoalSetting entry;

  const SettingsViews({super.key, required this.entry});

  @override
  State<SettingsViews> createState() => _SettingsViewsState();
}

class _SettingsViewsState extends State<SettingsViews> {

  late int currentSleep = 0;
  late int currentSteps = 0;
  late int currentScreenTime = 0;

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
        // Title of the screen
        title: const Text('Goal Setting'),
        
        // "Cancel" button: discards changes and returns to the previous screen
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        
        // "Add" button: saves changes and returns the updated entry
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Set Goals',
            onPressed: () => _popBack(context),
          ),
        ],

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1), // Add the bar here
            ),
          ),
        ),
      ),

      
      
      // Main content area with form fields for editing entry details
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size to content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sleep input field
              Container(
                width: 200, // Adjust width of the form
                child: Row(
                  children: [
                    const Text('Sleep: ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: TextFormField(
                        initialValue: currentSleep.toString(),
                        decoration: const InputDecoration(
                          isDense: true, // Makes the field smaller
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
              ),
              const SizedBox(height: 10),
              // Steps input field
              Container(
                width: 200,
                child: Row(
                  children: [
                    const Text('Steps: ', style: TextStyle(fontSize: 16)),
                    Expanded(
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
              ),
              const SizedBox(height: 10),
              // Screen Time input field
              Container(
                width: 200,
                child: Row(
                  children: [
                    const Text('Screen Time: ', style: TextStyle(fontSize: 16)),
                    Expanded(
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
              ),
            ],
          ),
        ),
      ),


    );
  }

    /// Saves the current field values to a new GoalSetting and returns to the previous screen.
  ///
  /// Parameters:
  ///     -context: current instance of entry
  /// Creates a new JournalEntry with the updated values and passes it back to the previous screen.
  void _popBack(BuildContext context) {
    final newEntry = GoalSetting(
      sleep: currentSleep,
      steps: currentSteps,
      screenTime: currentScreenTime
    );
    // Return to the previous screen with the modified GoalSetting as a result
    Navigator.pop(context, newEntry);
  }

}