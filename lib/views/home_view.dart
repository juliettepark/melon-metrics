import 'package:flutter/material.dart';
import 'package:melon_metrics/views/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void getHealthData(BuildContext context) async {
    HealthProvider healthProvider =
        Provider.of<HealthProvider>(context, listen: false);
    await healthProvider.updateHealthData();
    print('Calories burned: ${healthProvider.caloriesBurned}');
    print('Sleep hours: ${healthProvider.sleepHours}');
    print('Steps: ${healthProvider.steps}');
    print('Wellbeing score: ${healthProvider.wellbeingScore}');
  }

  @override
  Widget build(BuildContext context) {
    // return const Text('This is Home View');
    return 
      Consumer2<HealthProvider, GoalProvider>(
      builder: (context, healthProvider, goalProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              // Health stats
              Expanded(
                // flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ALL STATS CONTAINER
                    const Expanded(
                      flex: 1,
                      child: ProgressBar()
                      
                      // Column(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(bottom: 8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.nightlight, size: 30,),
                      //           Expanded(
                      //             child: LinearProgressIndicator(
                      //               value: 3/5,
                      //               backgroundColor: Colors.grey[300],
                      //               color: Colors.amber.shade200,
                      //               minHeight: 20,
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(bottom: 8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.nightlight, size: 30,),
                      //           Expanded(
                      //             child: LinearProgressIndicator(
                      //               value: 3/5,
                      //               backgroundColor: Colors.grey[300],
                      //               color: Colors.amber.shade200,
                      //               minHeight: 20,
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(bottom: 8.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.nightlight, size: 30,),
                      //           Expanded(
                      //             child: LinearProgressIndicator(
                      //               value: 3/5,
                      //               backgroundColor: Colors.grey[300],
                      //               color: Colors.amber.shade200,
                      //               minHeight: 20,
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.purple,
                        child: Text('Row piece 2'),
                      )
                    )
                  ],
                ),
              ),
          
              // Animation
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.pink,
                  child: const Image(image: AssetImage('assets/good.png'), width: double.infinity,)
                )
              ),
          
              // Refresh button
              ElevatedButton(
                onPressed: () => getHealthData(context),
                child: const Text('Refresh Health Data'),
              ),
              // Expanded(
              //   child: Container(
              //     color: Colors.blue,
              //     child: ElevatedButton(
              //       onPressed: () => getHealthData(context),
              //       child: const Text('Refresh Health Data'),
              //     ),
              //   )
              // ),
            ],
          ),
        );
        
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //       Text("Sleep: ${goalProvider.sleepHours.toString()}, \n Steps ${goalProvider.steps.toString()} \n Calories burned: ${goalProvider.calories.toString()} \n"),
        //       Text("Sleep: ${healthProvider.sleepHours.toString()}, \n Steps ${healthProvider.steps.toString()} \n Calories burned: ${healthProvider.caloriesBurned.toString()} \n"),
        //       // LinearProgressIndicator(
        //       //   value: 3/5,
        //       //   backgroundColor: Colors.grey[300],
        //       //   color: Colors.blue,
        //       //   minHeight: 100,
        //       // ),
        //       // Container(
        //       //   color: Colors.blue,
        //       //   child: Text('helo'),
        //       // ),
        //       ProgressBar(barIcon: Icons.night_shelter, goal: 5.0, actual: 3.0),
        //       ElevatedButton(
        //         onPressed: () => getHealthData(context),
        //         child: const Text('Refresh Health Data'),
        //       ),
        //   ],
        // );
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
