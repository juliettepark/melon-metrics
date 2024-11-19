import 'package:flutter/material.dart';
import 'package:health/health.dart';

void main() {
  runApp(const MainApp());
}

void getHealthData() async {
// configure the health plugin before use.
  Health().configure();

  // define the types to get
  var types = [
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.STEPS,
    HealthDataType.BLOOD_GLUCOSE,
  ];

  // requesting access to the data types before reading them
  bool requested = await Health().requestAuthorization(types);

  var now = DateTime.now();

  // fetch health data from the last 24 hours
  List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
      types: types);

  // get the number of steps for today
  var midnight = DateTime(now.year, now.month, now.day);
  int? steps = await Health().getTotalStepsInInterval(midnight, now);

  // print the results
  print('Steps: $steps');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: getHealthData,
            child: Text('Get Health Data'),
          ),
        ),
      ),
    );
  }
}
