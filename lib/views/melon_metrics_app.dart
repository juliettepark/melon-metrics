import 'package:flutter/material.dart';
import 'package:melon_metrics/models/goal_setting.dart';
import 'package:melon_metrics/views/home_view.dart';
import 'package:melon_metrics/views/settings_views.dart';

// Inspiried by navigation code from lecture
class MelonMetricsApp extends StatefulWidget {
  const MelonMetricsApp({super.key});
  

  @override
  State<MelonMetricsApp> createState() => _MelonMetricsAppState();
}

class _MelonMetricsAppState extends State<MelonMetricsApp> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // title: Text('owl power'),
      // ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState((){ // Executes code and then causes widget to re-build()
            _currentTabIndex = index;
          });
        },
        indicatorColor: theme.primaryColor,
        selectedIndex: _currentTabIndex,

        // This defines what is in the nav bar 
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Widget 1' ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Widget 2'),
          // NavigationDestination(icon: Icon(Icons.donut_large_outlined), label: 'Widget 3'),
          // NavigationDestination(icon: Icon(Icons.phone), label: 'Widget 4'),
        ],
      ),
      
      // Here we choose how to populate the body using the current value of _currentTabIndex
      body: Center(child: 
        switch (_currentTabIndex) {
          0 => const HomeView(),
          1 => SettingsViews( entry: GoalSetting(screenTime: 7, sleep: 5, steps: 1000),),
          _ => const Placeholder(),
        }
      )
    );
  }
}