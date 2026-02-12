import 'package:get/get.dart';
import '../controllers/login_controller.dart';

/// Initial binding for the app
/// This ensures LoginController is always available
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Put LoginController as a permanent dependency
    // This makes it available throughout the app lifecycle
    Get.put(LoginController(), permanent: true);
  }
}