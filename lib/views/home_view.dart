import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Text('This is Home View');
    return 
      Consumer2<HealthProvider, GoalProvider>(
      builder: (context, healthProvider, goalProvider, child) {
        return (
          Text("Sleep: ${goalProvider.sleep.toString()}")
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