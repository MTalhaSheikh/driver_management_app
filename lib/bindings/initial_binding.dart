import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../services/location_update_service.dart';

/// Initial binding for the app
/// This ensures LoginController and LocationUpdateService are always available
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
    Get.put(LocationUpdateService(), permanent: true);
  }
}