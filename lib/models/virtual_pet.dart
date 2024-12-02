import 'package:flame/components.dart';
import 'package:melon_metrics/models/virtual_pet_animation.dart';
import 'dart:async';

class VirtualPet extends Component with HasGameRef {
  late VirtualPetAnimation virtualPetAnimation;

  VirtualPet() : super() {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    virtualPetAnimation = VirtualPetAnimation();
    add(virtualPetAnimation);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
  }
}
