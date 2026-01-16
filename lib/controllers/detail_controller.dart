import 'package:get/get.dart';

class DetailController extends GetxController {
  // Trip data
  final RxString scheduledLabel = 'Today, 10:30 AM'.obs;
  final RxString pickupTitle = 'Heathrow Terminal 5'.obs;
  final RxString pickupSubtitle = 'London, TW6 2GA'.obs;
  final RxString dropoffTitle = 'The Savoy Hotel'.obs;
  final RxString dropoffSubtitle = 'Strand, London WC2R 0EU'.obs;
  final RxDouble distanceMiles = 18.4.obs;
  final RxInt durationMins = 45.obs;

  // Driver contact info
  final RxString driverName = 'James Anderson'.obs;
  final RxString driverPhone = '+128846261841'.obs;
}
