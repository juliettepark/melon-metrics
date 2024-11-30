import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:melon_metrics/models/virtual_pet.dart';
import 'package:melon_metrics/models/virtual_pet_data.dart';

class VirtualPetGame extends FlameGame {
  final VirtualPetData virtualPetData = VirtualPetData();

  @override
  Color backgroundColor() => const Color(0x00000000); // Flame defaults to black for some reason. This is transparent

  @override
  Future<void> onLoad() async {

    add(VirtualPet());

    return super.onLoad();
  }
}
