import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapController extends GetxController {
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxBool isTracking = false.obs;
  final RxBool isLoading = true.obs;
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  @override
  void onClose() {
    _positionStream?.cancel();
    super.onClose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Request location permission
      final status = await Permission.location.request();
      if (!status.isGranted) {
        isLoading.value = false;
        return;
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentPosition = position;
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void toggleTracking() {
    if (isTracking.value) {
      _stopTracking();
    } else {
      _startTracking();
    }
  }

  void _startTracking() async {
    try {
      final status = await Permission.location.request();
      if (!status.isGranted) return;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      isTracking.value = true;

      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // Update every 10 meters
        ),
      ).listen((Position position) {
        _currentPosition = position;
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      });
    } catch (e) {
      isTracking.value = false;
    }
  }

  void _stopTracking() {
    _positionStream?.cancel();
    _positionStream = null;
    isTracking.value = false;
  }

  void updateLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
  }
}

