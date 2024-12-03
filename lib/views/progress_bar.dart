import 'package:flutter/material.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {

  // IconData barIcon;
  // double goal;
  // double actual;
  HealthProvider healthProvider;
  GoalProvider goalProvider;
  ProgressBar({super.key, required this.healthProvider, required this.goalProvider});
  // const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final singleUseHealthProvider = Provider.of<HealthProvider>(context, listen:false);
    final singleUseGoalProvider = Provider.of<GoalProvider>(context, listen:false);

    return Column(
      children: [
        makeSingleBar(barIcon: Icons.nightlight, 
                      goal: singleUseGoalProvider.sleepHours.toDouble(), 
                      actual: goalProvider.sleepHours.toDouble(), 
                      fillBar: const Color.fromRGBO(116, 84, 106, 1)
                      // fillBar:Theme.of(context).colorScheme.inversePrimary
                      ),
        makeSingleBar(barIcon: Icons.directions_walk_rounded, 
                      goal: goalProvider.steps.toDouble(), 
                      actual: healthProvider.steps.toDouble(), 
                      fillBar: Theme.of(context).colorScheme.surfaceTint),
        makeSingleBar(barIcon: Icons.fireplace_outlined, 
                      goal: goalProvider.calories.toDouble(),
                      actual: healthProvider.caloriesBurned, 
                      fillBar: Color.fromRGBO(246, 126, 125, 1)),
        // makeSingleBar(barIcon: Icons.fireplace_outlined, 
        //               goal: 500,
        //               actual: 200, 
        //               fillBar: Colors.amber.shade200),
      ],
    );
    // return Column(
    //   children: [
    //     makeSingleBar(barIcon: Icons.nightlight, 
    //                   goal: singleUseGoalProvider.sleepHours.toDouble(), 
    //                   actual: singleUseHealthProvider.sleepHours, 
    //                   fillBar:Theme.of(context).colorScheme.inversePrimary),
    //     makeSingleBar(barIcon: Icons.directions_walk_rounded, 
    //                   goal: singleUseGoalProvider.steps.toDouble(), 
    //                   actual: singleUseHealthProvider.steps.toDouble(), 
    //                   fillBar: Theme.of(context).colorScheme.surfaceTint),
    //     makeSingleBar(barIcon: Icons.fireplace_outlined, 
    //                   goal: singleUseGoalProvider.calories.toDouble(),
    //                   actual: singleUseHealthProvider.caloriesBurned, 
    //                   fillBar: Colors.amber.shade200),
    //     // makeSingleBar(barIcon: Icons.fireplace_outlined, 
    //     //               goal: 500,
    //     //               actual: 200, 
    //     //               fillBar: Colors.amber.shade200),
    //   ],
    // );
    
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Row(
    //       children: [
    //         Icon(barIcon, size: 40,),
    //         const SizedBox(width: 10,),
    //         SizedBox(
    //           width: 200,
    //           child: LinearProgressIndicator(
    //             value: progress,
    //             backgroundColor: Colors.grey[300],
    //             color: Colors.amber.shade200,
    //             minHeight: 10,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }

  Widget makeSingleBar({required IconData barIcon, 
                        required double goal, 
                        required double actual, 
                        required Color fillBar}) {
    // Calculate the progress as a percentage
    double progress;

    // Make sure the progress doesn't exceed 100% (i.e., 1.0)
    print('Goal: ${goal}, Actual $actual');
    if (goal != 0.0 && actual != 0.0) {
      progress = actual / goal;
    } else {
      progress = 0.0;
    }
    progress = progress > 1.0 ? 1.0 : progress;
    // progress = goal == 0 || actual == 0 ? 0 : progress;
    

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(barIcon, size: 30,),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: fillBar,
              minHeight: 20,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          // Expanded(child: Padding(
          //   padding: const EdgeInsets.only( left: 8.0),
          //   child: Text('(${actual.toInt()} / ${goal.toInt()})'),
          // ))
        ],
      ),
    );
  }
}