import 'package:get/get.dart';
import '../models/trip_model.dart';

class DetailController extends GetxController {
  // Trip data
  late final TripModel trip;
  
  final RxString scheduledLabel = ''.obs;
  final RxString pickupTitle = ''.obs;
  final RxString pickupSubtitle = ''.obs;
  final RxString dropoffTitle = ''.obs;
  final RxString dropoffSubtitle = ''.obs;
  final RxDouble pickupLat = 0.0.obs;
  final RxDouble pickupLng = 0.0.obs;
  final RxDouble dropoffLat = 0.0.obs;
  final RxDouble dropoffLng = 0.0.obs;
  final RxDouble distanceMiles = 0.0.obs;
  final RxInt durationMins = 0.obs;
  final RxString notes = ''.obs;
  final RxString flightNumber = ''.obs;
  
  // Customer data
  final RxString customerName = ''.obs;
  final RxString customerPhone = ''.obs;
  final RxString customerEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTripData();
  }

  /// Load trip data from arguments
  void _loadTripData() {
    try {
      // Get trip from navigation arguments
      final args = Get.arguments;
      
      if (args != null && args is TripModel) {
        trip = args;
        
        // Update observables
        scheduledLabel.value = trip.scheduledLabel;
        pickupTitle.value = trip.pickupTitle;
        pickupSubtitle.value = trip.pickupSubtitle;
        dropoffTitle.value = trip.dropoffTitle;
        dropoffSubtitle.value = trip.dropoffSubtitle;
        pickupLat.value = trip.pickupLat;
        pickupLng.value = trip.pickupLng;
        dropoffLat.value = trip.dropoffLat;
        dropoffLng.value = trip.dropoffLng;
        distanceMiles.value = trip.distanceMiles;
        durationMins.value = trip.durationMins;
        notes.value = trip.displayNotes;
        flightNumber.value = trip.flightNumber;
        
        // Customer data
        customerName.value = trip.displayPassengerName;
        customerPhone.value = trip.customerPhone ?? 'No phone';
        customerEmail.value = trip.customerEmail ?? 'No email';
      } else {
        // Fallback to default values if no trip data
        print('Warning: No trip data provided to DetailController');
        _setDefaultValues();
      }
    } catch (e) {
      print('Error loading trip data: $e');
      _setDefaultValues();
    }
  }

  void _setDefaultValues() {
    scheduledLabel.value = 'No trip data';
    pickupTitle.value = 'Pickup location';
    pickupSubtitle.value = '';
    dropoffTitle.value = 'Dropoff location';
    dropoffSubtitle.value = '';
    distanceMiles.value = 0.0;
    durationMins.value = 0;
    notes.value = 'No notes';
    flightNumber.value = '';
    customerName.value = 'Customer';
    customerPhone.value = '';
    customerEmail.value = '';
  }
}