import 'package:flame/components.dart';
import 'package:melon_metrics/models/virtual_pet_animation.dart';
import 'dart:async';

/// This class creates the actual pet! It adds the initial animations, data and styling.
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

  /// Initializes the virtual pet using the parents update.
  /// Parameters: None
  /// Returns: A Future that completes when initialization is done
  @override
  Future<void> update(double dt) async {
    super.update(dt);
  }
}
