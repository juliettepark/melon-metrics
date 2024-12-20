import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:melon_metrics/models/virtual_pet_animation_config.dart';
import 'package:melon_metrics/models/virtual_pet_animation_state.dart';
import 'dart:async';

import 'package:melon_metrics/models/virtual_pet_game.dart';

const double virtualPetSize = 250;
bool userTriggeredAnimation = false;

/// This is the main animation class. It defines the update function that Flame calls
/// for each of dt. This class describes the various movements, changes in state and direction too
class VirtualPetAnimation extends SpriteAnimationComponent
    with HasGameRef<VirtualPetGame>, TapCallbacks {
  static final VirtualPetAnimationDataConfig _animationDataConfig =
      VirtualPetAnimationDataConfig();

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation forwardWalkAnimation;
  late final SpriteAnimation backwardWalkAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation deathAnimation;
  late final SpriteAnimation sadAnimation;

  double deltaY = 0.5;
  double deltaX = 0;
  double movementTime = 0;

  int direction = 0;

  bool facingRight = true;

  VirtualPetAnimation() : super(size: Vector2.all(virtualPetSize)) {
    debugMode = true;
  }

  /// Handles tap events on the virtual pet.
  /// Triggers a jump animation and temporarily disables walk cycle logic.
  /// Parameters:
  ///   event: The TapDownEvent that triggered this method
  /// Returns: None
  @override
  void onTapDown(TapDownEvent event) {
    // Trigger jump animation on tap
    userTriggeredAnimation = true; // Flag to prevent walkCycle logic during user input
    changeState(VirtualPetAnimationState.jump);

    // Revert to idle animation after jump completes and re-enable walkCycle logic
    Future.delayed(const Duration(seconds: 2, microseconds: 400), () {
      userTriggeredAnimation = false;
      changeState(VirtualPetAnimationState.idle);
    });
  }

  /// Changes the animation state of the virtual pet.
  /// Updates the current animation and direction based on the new state.
  /// Parameters:
  ///   animationState: The new VirtualPetAnimationState to apply
  /// Returns: void
  void changeState(VirtualPetAnimationState animationState) {
    // print("Changing to state: $animationState");
    switch (animationState) {
      case VirtualPetAnimationState.idle:
        animation = idleAnimation;
        direction = 0;
        break;
      case VirtualPetAnimationState.walkForward:
        animation = forwardWalkAnimation;
        direction = 1;
        break;
      case VirtualPetAnimationState.walkBackward:
        animation = backwardWalkAnimation;
        direction = -1;
        break;
      case VirtualPetAnimationState.jump:
        animation = jumpAnimation;
        break;
      case VirtualPetAnimationState.death:
        animation = deathAnimation;
        break;
      case VirtualPetAnimationState.sad:
        animation = sadAnimation;
        direction = 0;
        break;
    }
  }

  /// Initializes the virtual pet animation component.
  /// Sets the initial position and loads animations (by defaalt idle state)
  /// Parameters: None
  /// Returns: A Future that completes when initialization is done
  @override
  Future<void> onLoad() async {
    try {
      await super.onLoad();
      position = Vector2(
        (gameRef.size.x / 3) - (size.x / 2),
        (gameRef.size.y / 2) - (size.y / 2),
      );
      await loadAnimations();  // Ensure this is awaited
      animation = idleAnimation;  // Now it’s safe to assign the animation
    } catch(e) {
      // print("OMG ALERT: $e");
    }
  }

  /// Updates the virtual pet's state and position each frame.
  /// Handles movement and animation changes based on health and walk cycle.
  /// IMPT: Overrides flame's update, and this is called every half second or so
  /// Parameters:
  ///   dt: The time elapsed since the last update
  /// Returns: A Future that completes when the update is done
  @override
  Future<void> update(double dt) async {
    super.update(dt);

    if (userTriggeredAnimation) return;

    if (direction == 1) {
      position.x += 1;
    }

    if (direction == 0) {
      position.x += 0;
    }

    if (direction == -1) {
      position.x -= 1;
    }

    if (gameRef.virtualPetData.healthState.value == 2) {
      // print("this is an if case, happy healthy");
      if (gameRef.virtualPetData.walkCycle.value < 3) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 5) {
        changeState(VirtualPetAnimationState.walkBackward);
        if (facingRight) {
          flipHorizontallyAroundCenter();
          facingRight = false;
        }
      } else if (gameRef.virtualPetData.walkCycle.value < 7) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 9) {
        changeState(VirtualPetAnimationState.jump);
      } else if (gameRef.virtualPetData.walkCycle.value < 10) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 12) {
        changeState(VirtualPetAnimationState.walkForward);
        if (facingRight == false) {
          flipHorizontallyAroundCenter();
          facingRight = true;
        }
      } else if (gameRef.virtualPetData.walkCycle.value < 14) {
        changeState(VirtualPetAnimationState.jump);
      } else if (gameRef.virtualPetData.walkCycle.value <= 16) {
        changeState(VirtualPetAnimationState.idle);
      }
    }

    else if (gameRef.virtualPetData.healthState.value == 0) {
      // print("this is an else if case, sad unhappy");
      if (gameRef.virtualPetData.walkCycle.value < 3) {
        changeState(VirtualPetAnimationState.sad);
      } else if (gameRef.virtualPetData.walkCycle.value < 5) {
        changeState(VirtualPetAnimationState.walkBackward);
        if (facingRight) {
          flipHorizontallyAroundCenter();
          facingRight = false;
        }
      } else if (gameRef.virtualPetData.walkCycle.value < 7) {
        changeState(VirtualPetAnimationState.sad);
      } else if (gameRef.virtualPetData.walkCycle.value < 9) {
        changeState(VirtualPetAnimationState.jump);
      } else if (gameRef.virtualPetData.walkCycle.value < 10) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 12) {
        changeState(VirtualPetAnimationState.walkForward);
        if (facingRight == false) {
          flipHorizontallyAroundCenter();
          facingRight = true;
        }
      } else if (gameRef.virtualPetData.walkCycle.value < 14) {
        changeState(VirtualPetAnimationState.jump);
      } else if (gameRef.virtualPetData.walkCycle.value <= 16) {
        changeState(VirtualPetAnimationState.sad);
      }
    }

    else {
      // print("else case idle");
      if (gameRef.virtualPetData.walkCycle.value < 3) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 5) {
        changeState(VirtualPetAnimationState.walkBackward);
        if (facingRight) {
          flipHorizontallyAroundCenter();
          facingRight = false;
        }
      } else if (gameRef.virtualPetData.walkCycle.value < 7) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 9) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 10) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value < 12) {
        changeState(VirtualPetAnimationState.walkForward);
        if (facingRight == false) {
          flipHorizontallyAroundCenter();
          facingRight = true;
        }
      } else if (gameRef.virtualPetData.walkCycle.value < 14) {
        changeState(VirtualPetAnimationState.idle);
      } else if (gameRef.virtualPetData.walkCycle.value <= 16) {
        changeState(VirtualPetAnimationState.idle);
      }
    }
    // Implement movement based on direction
  }

  /// Loads all animations for the virtual pet.
  /// Initializes different animations for various states.
  /// Parameters: None
  /// Returns: A Future that completes when all animations are loaded
  Future<void> loadAnimations() async {
    idleAnimation = SpriteAnimation.fromFrameData(
        await gameRef.images.load(_animationDataConfig.idleAnimationData.animationPath),
        _animationDataConfig.idleAnimationData.animationData);
    forwardWalkAnimation = SpriteAnimation.fromFrameData(
        await gameRef.images.load(_animationDataConfig.walkAnimationData.animationPath),
        _animationDataConfig.walkAnimationData.animationData);
    backwardWalkAnimation = SpriteAnimation.fromFrameData(
        await gameRef.images.load(_animationDataConfig.walkAnimationData.animationPath),
        _animationDataConfig.walkAnimationData.animationData);
    jumpAnimation = SpriteAnimation.fromFrameData(
        await gameRef.images.load(_animationDataConfig.jumpAnimationData.animationPath),
        _animationDataConfig.jumpAnimationData.animationData);
    deathAnimation = SpriteAnimation.fromFrameData(
        await gameRef.images.load(_animationDataConfig.deathAnimationData.animationPath),
        _animationDataConfig.deathAnimationData.animationData);
    sadAnimation = SpriteAnimation.fromFrameData(
        await gameRef.images.load(_animationDataConfig.sadAnimationData.animationPath),
        _animationDataConfig.sadAnimationData.animationData);
  }
}
