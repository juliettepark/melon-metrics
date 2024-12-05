import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:melon_metrics/models/virtual_pet.dart';
import 'package:melon_metrics/models/virtual_pet_data.dart';
import 'package:melon_metrics/providers/health_provider.dart';

/// This class initializes a virtual pet game. It sets a transparent background for the pet
/// And also initializes the health provider to update the state of the pet.
/// It feeds the data from virtual pet data into the game itself.
class VirtualPetGame extends FlameGame {
  final VirtualPetData virtualPetData = VirtualPetData();

  @override
  Color backgroundColor() => const Color(
      0x00000000); // Flame defaults to black for some reason. This is transparent

  @override
  Future<void> onLoad() async {
    add(HealthProvider(null)); // TODO: pass in isar here
    add(VirtualPet());

    return super.onLoad();
  }
}
