import 'package:get/get.dart';

import '../controllers/trip_info_controller.dart';

class TripInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripInfoController>(() => TripInfoController());
  }
}

