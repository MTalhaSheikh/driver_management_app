import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launches the device phone dialer with the given [phone] number.
Future<void> launchPhoneDialer(String phone) async {
  if (phone.trim().isEmpty) return;
  final uri = Uri(scheme: 'tel', path: phone.trim());
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    Get.snackbar(
      'Cannot dial',
      'No app available to make calls',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
