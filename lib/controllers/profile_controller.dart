import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString name = 'Michael Den'.obs;
  final RxString email = 'michaelben@gmail.com'.obs;
  final RxString phone = '+1 124951625494'.obs;
  final RxString address = '2118 Thornridge Cir. Syracuse, Connecticut 35624'.obs;
  final RxBool isActive = true.obs;

  void toggleActiveStatus() {
    isActive.value = !isActive.value;
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}

