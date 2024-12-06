import 'package:flutter/material.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart';

/// Provides an inherited widget wrapper for sharing a VirtualPetGame in the widget tree.
/// Allows descendant widgets to access and react to the virtual pet game data efficiently.
class InheritedVirtualPetGameWrapper extends InheritedWidget {
  final VirtualPetGame virtualPetGame;

  /// Constructor for a new InheritedVirtualPetGameWrapper.
  /// Takes in the game instance and a child widget.
  /// Parameters:
  ///   virtualPetGame: The VirtualPetGame instance to be shared.
  ///   child: The child widget to be wrapped.
  ///   key: An optional key for the widget.
  /// Returns: A new InheritedVirtualPetGameWrapper instance.
  const InheritedVirtualPetGameWrapper({
    required this.virtualPetGame,
    required super.child,
    super.key
  });

  /// Decides if the widget should rebuild when updated.
  /// Always returns true to ensure updates are propagated.
  /// Parameters:
  ///   oldWidget: The previous instance of the widget.
  /// Returns: A boolean indicating whether the widget should update.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  /// Finds the nearest InheritedVirtualPetGameWrapper in the widget tree.
  /// Throws an assertion error if no wrapper is found.
  /// Parameters:
  ///   context: The BuildContext to search from.
  /// Returns: The nearest InheritedVirtualPetGameWrapper instance.
  static InheritedVirtualPetGameWrapper of(BuildContext context) {
    final InheritedVirtualPetGameWrapper? result = context
      .dependOnInheritedWidgetOfExactType<InheritedVirtualPetGameWrapper>();
    assert(result != null, 'No Game Wrapper is present in context');
    return result!;
  }
}
