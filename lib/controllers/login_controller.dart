import 'package:get/get.dart';

import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login() async {
    // Form-level validation happens in the view; keep a fallback here too.
    if (!GetUtils.isEmail(email.value.trim())) {
      errorMessage.value = 'Enter a valid email';
      return;
    }
    if (password.value.trim().length < 6) {
      errorMessage.value = 'Password must be at least 6 characters';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with real auth logic
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = 'Login failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}

