import 'package:flame/components.dart';

/// Base image folder is at assets/images. When specifying the animation .png path, provide the
/// file path relative to assets/images folder.
/// Represents animation data for a virtual pet, including the file path and animation settings.
/// Used to define individual animations with specific properties like frame count and timing.
class VirtualPetAnimationDataConfig {
  final VirtualPetAnimationData idleAnimationData = VirtualPetAnimationData("owl/owlet_idle.png",
      SpriteAnimationData.sequenced(amount: 4, stepTime: 0.30, textureSize: Vector2.all(32)));

  final VirtualPetAnimationData walkAnimationData = VirtualPetAnimationData("owl/owlet_walk.png",
      SpriteAnimationData.sequenced(amount: 6, stepTime: 0.30, textureSize: Vector2.all(32)));

  final VirtualPetAnimationData jumpAnimationData = VirtualPetAnimationData("owl/owlet_jump.png",
      SpriteAnimationData.sequenced(amount: 8, stepTime: 0.30, textureSize: Vector2.all(32)));

  final VirtualPetAnimationData sadAnimationData = VirtualPetAnimationData("owl/owlet_sad.png",
      SpriteAnimationData.sequenced(amount: 6, stepTime: 0.30, textureSize: Vector2.all(32)));

  final VirtualPetAnimationData deathAnimationData = VirtualPetAnimationData(
      "owl/owlet_death.png",
      SpriteAnimationData.sequenced(
          amount: 9, stepTime: 0.30, textureSize: Vector2.all(32), loop: false));
}

/// Configures animation data for a virtual pet, including file paths and animation properties.
/// Provides predefined animations like idle, walk, jump, sad, and death.
class VirtualPetAnimationData {
  String animationPath;
  SpriteAnimationData animationData;

  VirtualPetAnimationData(this.animationPath, this.animationData);
}
