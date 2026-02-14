import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/login_controller.dart';
import 'api_service.dart';

/// Sends driver location to the API every 10 seconds, even in background.
class LocationUpdateService extends GetxService {
  final FlutterBackgroundService _backgroundService =
      FlutterBackgroundService();

  int? _activeTripId;

  /// Initialize the background service
  Future<void> initialize() async {
    await _backgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'driver_location_channel',
        initialNotificationTitle: 'Limo Guy',
        initialNotificationContent: 'Location tracking active',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  /// Set the active trip id
  Future<void> setActiveTripId(int? tripId) async {
    _activeTripId = tripId;
    if (await _backgroundService.isRunning()) {
      _backgroundService.invoke('setTripId', {'tripId': tripId});
    }
  }

  /// Start the background location service
  Future<void> start() async {
    final token = Get.find<LoginController>().authToken.value;
    if (token.isEmpty) return;

    // Request permissions
    await _requestPermissions();

    // Start the background service
    await _backgroundService.startService();

    // Send initial data
    _backgroundService.invoke('setToken', {'token': token});
    if (_activeTripId != null) {
      _backgroundService.invoke('setTripId', {'tripId': _activeTripId});
    }
  }

  /// Stop the background location service
  Future<void> stop() async {
    _backgroundService.invoke('stopService');
    _activeTripId = null;
  }

  Future<void> _requestPermissions() async {
    // Request notification permission first (Android 13+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    await Permission.location.request();
    await Permission.locationAlways.request();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}

/// Background service entry point
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  String? authToken;
  int? tripId;
  Timer? timer;

  service.on('setToken').listen((event) {
    authToken = event!['token'];
  });

  service.on('setTripId').listen((event) {
    tripId = event!['tripId'];
  });

  service.on('stopService').listen((event) {
    timer?.cancel();
    service.stopSelf();
  });

  // Send location every 10 seconds
  timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (authToken == null || authToken!.isEmpty) return;

    try {
      final position = await _getPosition();
      if (position != null) {
        await _sendLocationToApi(
          token: authToken!,
          latitude: position.latitude,
          longitude: position.longitude,
          tripId: tripId,
        );

        // Update notification
        if (service is AndroidServiceInstance) {
          service.setForegroundNotificationInfo(
            title: 'Limo Guy',
            content:
                'Last update: ${DateTime.now().toString().substring(11, 19)}',
          );
        }
      }
    } catch (e) {
      print('Background location error: $e');
    }
  });

  // Send first location immediately
  if (authToken != null) {
    final position = await _getPosition();
    if (position != null) {
      await _sendLocationToApi(
        token: authToken!,
        latitude: position.latitude,
        longitude: position.longitude,
        tripId: tripId,
      );

      // Set initial notification
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'Limo Guy',
          content: 'Location tracking started',
        );
      }
    }
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

Future<Position?> _getPosition() async {
  try {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } catch (e) {
    print('Get position error: $e');
    return null;
  }
}

Future<void> _sendLocationToApi({
  required String token,
  required double latitude,
  required double longitude,
  int? tripId,
}) async {
  try {
    final apiService = ApiService();
    await apiService.updateDriverLocation(
      token: token,
      latitude: latitude,
      longitude: longitude,
      tripId: tripId,
    );
  } catch (e) {
    print('Send location error: $e');
  }
}
