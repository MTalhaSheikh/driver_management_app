import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy put: creates controller only when needed
    Get.lazyPut<HomeController>(() => HomeController());
    
    // Alternative: Put immediately
    // Get.put(HomeController());
  }
}
