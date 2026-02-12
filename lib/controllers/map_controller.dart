import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../models/trip_model.dart';

class MapController extends GetxController {
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isTracking = false.obs;
  
  // Trip location data (if opened from trip details)
  final RxDouble pickupLat = 0.0.obs;
  final RxDouble pickupLng = 0.0.obs;
  final RxDouble dropoffLat = 0.0.obs;
  final RxDouble dropoffLng = 0.0.obs;
  final RxBool hasTripData = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTripData();
    _getCurrentLocation();
  }

  /// Load trip data if provided
  void _loadTripData() {
    try {
      final args = Get.arguments;
      
      if (args != null && args is TripModel) {
        // Load trip locations
        pickupLat.value = args.pickupLat;
        pickupLng.value = args.pickupLng;
        dropoffLat.value = args.dropoffLat;
        dropoffLng.value = args.dropoffLng;
        hasTripData.value = true;
        
        // Set initial camera to pickup location
        latitude.value = args.pickupLat;
        longitude.value = args.pickupLng;
      } else if (args != null && args is Map<String, dynamic>) {
        // Handle map arguments
        pickupLat.value = args['pickupLat'] ?? 0.0;
        pickupLng.value = args['pickupLng'] ?? 0.0;
        dropoffLat.value = args['dropoffLat'] ?? 0.0;
        dropoffLng.value = args['dropoffLng'] ?? 0.0;
        
        if (pickupLat.value != 0.0 && pickupLng.value != 0.0) {
          hasTripData.value = true;
          latitude.value = pickupLat.value;
          longitude.value = pickupLng.value;
        }
      }
    } catch (e) {
      print('Error loading trip data in MapController: $e');
      hasTripData.value = false;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isLoading.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      
      // Only update location if we don't have trip data
      // or if user manually requests current location
      if (!hasTripData.value) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      }
      
      isLoading.value = false;
    } catch (e) {
      print('Error getting location: $e');
      isLoading.value = false;
    }
  }

  void toggleTracking() {
    isTracking.value = !isTracking.value;
    if (isTracking.value) {
      _startLocationTracking();
    } else {
      _stopLocationTracking();
    }
  }

  void _startLocationTracking() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      if (isTracking.value) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      }
    });
  }

  void _stopLocationTracking() {
    // Location stream will stop when isTracking is false
  }

  /// Center on current location
  Future<void> centerOnCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  /// Center on pickup location
  void centerOnPickup() {
    if (hasTripData.value && pickupLat.value != 0.0) {
      latitude.value = pickupLat.value;
      longitude.value = pickupLng.value;
    }
  }

  /// Center on dropoff location
  void centerOnDropoff() {
    if (hasTripData.value && dropoffLat.value != 0.0) {
      latitude.value = dropoffLat.value;
      longitude.value = dropoffLng.value;
    }
  }

  @override
  void onClose() {
    isTracking.value = false;
    super.onClose();
  }
}