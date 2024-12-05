import 'package:flutter/material.dart';
import 'package:melon_metrics/models/virtual_pet_game.dart';

/// Provides an inherited widget wrapper for sharing a VirtualPetGame in the widget tree.
/// Allows descendant widgets to access and react to the virtual pet game data efficiently.
class InheritedVirtualPetGameWrapper extends InheritedWidget {
  final VirtualPetGame virtualPetGame;

  const InheritedVirtualPetGameWrapper({
    required this.virtualPetGame,
    required super.child,
    super.key
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static InheritedVirtualPetGameWrapper of(BuildContext context) {
    final InheritedVirtualPetGameWrapper? result = context
      .dependOnInheritedWidgetOfExactType<InheritedVirtualPetGameWrapper>();
    assert(result != null, 'No Game Wrapper is present in context');
    return result!;
  }
}
