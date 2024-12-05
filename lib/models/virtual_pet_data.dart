import 'package:flutter/foundation.dart';

/// Manages virtual pet's data with properties like walk cycle and health state.
/// Uses ValueNotifier to notify listeners of state changes.
class VirtualPetData {
  final walkCycle = ValueNotifier<int>(16); // decrements with a timer
  final healthState = ValueNotifier<int>(1); // has 3 states of health - 0 = bad, 1 = ok, 3 = good
}
