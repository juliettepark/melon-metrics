import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:melon_metrics/models/inherited_virtual_pet_game_wrapper.dart';
import 'package:melon_metrics/views/progress_bar.dart';
import 'package:melon_metrics/views/weather_widget.dart';
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
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
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
                    Expanded(
                      flex: 2,
                      child: ProgressBar(healthProvider: healthProvider, goalProvider: goalProvider)
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        // color: Colors.purple,
                        // child: Text('Row piece 2'),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: WeatherWidget(),
                        ),
                      )
                    )
                  ],
                ),
              ),

              // Animation
              Expanded(
                flex: 4,
                child: Container(
                  // color: Colors.pink,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        width: 3,
                      ),
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        width: 3,
                      ),
                    ),
                  ),
                  // child: const Image(image: AssetImage('assets/good.png'), width: double.infinity,)
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GameWidget(
                      game: InheritedVirtualPetGameWrapper.of(context).virtualPetGame,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Refresh button
              ElevatedButton(
                onPressed: () => getHealthData(context),
                child: const Text('Refresh Health Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(116, 84, 106, 1),
                  foregroundColor: const Color.fromRGBO(246, 200, 177, 1)
                ),
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
