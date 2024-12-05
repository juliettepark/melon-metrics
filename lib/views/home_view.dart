import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:melon_metrics/models/inherited_virtual_pet_game_wrapper.dart';
import 'package:melon_metrics/views/progress_bar.dart';
import 'package:melon_metrics/views/weather_widget.dart';
import 'package:provider/provider.dart';
import 'package:melon_metrics/providers/goal_provider.dart';
import 'package:melon_metrics/providers/health_provider.dart';

// Represents the home screen where users can inspect and track
// their health progress and interact with their pet!
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Do another fetch of the health data from an updated health
  // provider.
  void getHealthData(BuildContext context) async {
    HealthProvider healthProvider =
        Provider.of<HealthProvider>(context, listen: false);
    await healthProvider.updateHealthData();
    // print('Calories burned: ${healthProvider.caloriesBurned}');
    // print('Sleep hours: ${healthProvider.sleepHours}');
    // print('Steps: ${healthProvider.steps}');
    // print('Wellbeing score: ${healthProvider.wellbeingScore}');
  }

  // Home page with health progress and animation of pet
  @override
  Widget build(BuildContext context) {
    return
      Consumer2<HealthProvider, GoalProvider>(
      builder: (context, healthProvider, goalProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
          child: Column(
            children: <Widget>[
              // HEALTH STATS AND WEATHER
              Expanded(
                // flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // ALL PROGRESS BARS
                    Expanded(
                      flex: 2,
                      child: ProgressBar(healthProvider: healthProvider, goalProvider: goalProvider)
                    ),

                    // WEATHER EXERCISE RECOMMENDATION
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: WeatherWidget(),
                        ),
                      )
                    )
                  ],
                ),
              ),

              // ANIMATION CONTAINER
              Expanded(
                flex: 4,
                child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GameWidget(
                      game: InheritedVirtualPetGameWrapper.of(context).virtualPetGame,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // REFRESH HEALTH DATA BUTTON
              ElevatedButton(
                onPressed: () => getHealthData(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(116, 84, 106, 1),
                  foregroundColor: const Color.fromRGBO(246, 200, 177, 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Current Health: ${healthProvider.getHealthCondition()}\nRefresh Data', textAlign: TextAlign.center,)
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
