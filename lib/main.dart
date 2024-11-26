import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:melon_metrics/models/inherited_virtual_pet_game_wrapper.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart'; // Ensure the game is imported

void main() {
  runApp(
    InheritedVirtualPetGameWrapper(
      virtualPetGame: VirtualPetGame(), // Initialize the game
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Optional: to hide the debug banner
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: GameWidget(
              game: InheritedVirtualPetGameWrapper.of(context).virtualPetGame,
            ),
          ),
        ),
      ),
    );
  }
}
