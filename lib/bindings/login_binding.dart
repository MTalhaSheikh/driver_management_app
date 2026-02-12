import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // LoginController is already initialized in InitialBinding as permanent
    // So we just ensure it exists, don't create a new instance
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }
    
    // If you need to reset the controller state when returning to login
    // You can do it here:
    // final controller = Get.find<LoginController>();
    // controller.resetState();
  }
}