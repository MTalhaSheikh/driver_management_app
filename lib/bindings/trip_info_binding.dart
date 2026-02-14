import 'package:get/get.dart';
import 'package:limo_guy/controllers/detail_controller.dart';

import '../controllers/trip_info_controller.dart';

class TripInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripInfoController>(() => TripInfoController());
    Get.lazyPut<DetailController>(() => DetailController());
  }
}

