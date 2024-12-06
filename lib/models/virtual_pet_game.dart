import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:melon_metrics/models/virtual_pet.dart';
import 'package:melon_metrics/models/virtual_pet_data.dart';
import 'package:melon_metrics/providers/health_provider.dart';

/// This class initializes a virtual pet game. It sets a transparent background for the pet
/// And also initializes the health provider to update the state of the pet.
/// It feeds the data from virtual pet data into the game itself.
class VirtualPetGame extends FlameGame {
  final VirtualPetData virtualPetData = VirtualPetData();
  final Isar isar;

  VirtualPetGame(this.isar);

  @override
  Color backgroundColor() => const Color(
      0x00000000); // Flame defaults to black for some reason. This is transparent

  /// Initializes the game by adding necessary components.
  /// Adds a HealthProvider and a VirtualPet to the game.
  /// Parameters: None
  /// Returns: A Future that completes when initialization is done
  @override
  Future<void> onLoad() async {
    add(HealthProvider(null));
    add(VirtualPet());

    return super.onLoad();
  }
}
