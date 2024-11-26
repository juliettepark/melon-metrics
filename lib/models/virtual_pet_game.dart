import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:melon_metrics/models/virtual_pet.dart';
import 'package:melon_metrics/models/virtual_pet_data.dart';

class VirtualPetGame extends FlameGame {
  final VirtualPetData virtualPetData = VirtualPetData();

  @override
  Color backgroundColor() => Colors.red;

  @override
  Future<void> onLoad() async {
    // add(HealthTimer());
    // add(HealthBar());

    // add(LevelTimer());
    // add(LevelBar());

    // add(WalkTimer());

    add(VirtualPet());

    return super.onLoad();
  }
}
