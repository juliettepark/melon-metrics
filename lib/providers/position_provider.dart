import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String _error = '';
  Timer? _positionTimer;

  bool get hasPosition => _latitude != null && _longitude != null;
  String get error => _error;

  PositionProvider() {
    _updatePosition();
    _startPositionTimer();
  }

  Future<double> getLatitude() async {
    if (_latitude == null) {
      await _updatePosition();
    }
    return _latitude!;
  }

  Future<double> getLongitude() async {
    if (_longitude == null) {
      await _updatePosition();
    }
    return _longitude!;
  }

  void _startPositionTimer() {
    _positionTimer = Timer.periodic(const Duration(minutes: 15), (timer) {
      _updatePosition();
    });
  }

  Future<void> _updatePosition() async {
    try {
      final Position position = await _determinePosition();
      _latitude = position.latitude;
      _longitude = position.longitude;
      _error = '';
      notifyListeners();
    } catch (error) {
      _latitude = null;
      _longitude = null;
      _error = error.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    super.dispose();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}