import 'package:flutter/foundation.dart';

class VirtualPetData {
  final walkCycle = ValueNotifier<int>(16);
  final healthState = ValueNotifier<int>(1);
}
