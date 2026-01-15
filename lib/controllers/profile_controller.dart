import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString name = 'John Doe'.obs;
  final RxString email = 'john.doe@example.com'.obs;
  final RxString phone = '+1234567890'.obs;
  final RxString role = 'Driver'.obs;

  void updateName(String value) => name.value = value;
  void updatePhone(String value) => phone.value = value;
}

