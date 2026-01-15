import 'package:get/get.dart';

class MapController extends GetxController {
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxBool isTracking = false.obs;

  void toggleTracking() {
    isTracking.value = !isTracking.value;
  }

  void updateLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
  }
}

