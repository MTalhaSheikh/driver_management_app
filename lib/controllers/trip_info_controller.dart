import 'package:get/get.dart';
import '../models/trip_model.dart';

enum TripProgressStage {
  onTheWay,
  arrived,
  pickPassenger,
  finishedRide,
}

class TripInfoController extends GetxController {
  // Trip data
  late final TripModel trip;
  
  final RxString currentTripId = ''.obs;
  final RxString pickupTitle = ''.obs;
  final RxString pickupSubtitle = ''.obs;
  final RxString dropoffTitle = ''.obs;
  final RxString dropoffSubtitle = ''.obs;
  final RxDouble pickupLat = 0.0.obs;
  final RxDouble pickupLng = 0.0.obs;
  final RxDouble dropoffLat = 0.0.obs;
  final RxDouble dropoffLng = 0.0.obs;
  final RxString scheduledLabel = ''.obs;
  final RxDouble distanceMiles = 0.0.obs;
  final RxInt durationMins = 0.obs;
  final RxString passengerName = ''.obs;
  final RxString passengerPhone = ''.obs; // Will be added to API later
  final RxString notes = ''.obs;

  final Rx<TripProgressStage> stage = TripProgressStage.onTheWay.obs;

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
        currentTripId.value = trip.id.toString();
        pickupTitle.value = trip.pickupTitle;
        pickupSubtitle.value = trip.pickupSubtitle;
        dropoffTitle.value = trip.dropoffTitle;
        dropoffSubtitle.value = trip.dropoffSubtitle;
        pickupLat.value = trip.pickupLat;
        pickupLng.value = trip.pickupLng;
        dropoffLat.value = trip.dropoffLat;
        dropoffLng.value = trip.dropoffLng;
        scheduledLabel.value = trip.scheduledLabel;
        distanceMiles.value = trip.distanceMiles;
        durationMins.value = trip.durationMins;
        passengerName.value = trip.displayPassengerName;
        notes.value = trip.displayNotes;
        
        // Use customer phone from API, fallback to placeholder if not available
        passengerPhone.value = trip.customerPhone ?? 'Phone not available';
        
        // Determine initial stage based on trip status
        _setInitialStage();
      } else {
        // Fallback to default values if no trip data
        print('Warning: No trip data provided to TripInfoController');
        _setDefaultValues();
      }
    } catch (e) {
      print('Error loading trip data: $e');
      _setDefaultValues();
    }
  }

  void _setInitialStage() {
    // Set initial stage based on trip status
    // When trip is in progress, start at "On the way" stage
    switch (trip.tripStatus) {
      case TripStatus.pending:
      case TripStatus.inProgress:
        // Start at first stage: On the way
        stage.value = TripProgressStage.onTheWay;
        break;
      case TripStatus.completed:
        stage.value = TripProgressStage.finishedRide;
        break;
      default:
        stage.value = TripProgressStage.onTheWay;
    }
  }

  void _setDefaultValues() {
    currentTripId.value = '';
    pickupTitle.value = 'Pickup location';
    pickupSubtitle.value = '';
    dropoffTitle.value = 'Dropoff location';
    dropoffSubtitle.value = '';
    scheduledLabel.value = 'No trip data';
    distanceMiles.value = 0.0;
    durationMins.value = 0;
    passengerName.value = 'Passenger';
    passengerPhone.value = '+1 (XXX) XXX-XXXX';
    notes.value = '';
  }

  String get stageTitle {
    switch (stage.value) {
      case TripProgressStage.onTheWay:
        return 'On The Way';
      case TripProgressStage.pickPassenger:
        return 'Pick Passenger';
      case TripProgressStage.arrived:
        return 'Arrived';
      case TripProgressStage.finishedRide:
        return 'Finished Trip';
    }
  }

  void advanceStage() {
    switch (stage.value) {
      case TripProgressStage.onTheWay:
        // First: On the way → Second: Arrived
        stage.value = TripProgressStage.arrived;
        break;
      case TripProgressStage.arrived:
        // Second: Arrived → Third: Pick Passenger
        stage.value = TripProgressStage.pickPassenger;
        break;
      case TripProgressStage.pickPassenger:
        // Third: Pick Passenger → Fourth: Finished the trip
        stage.value = TripProgressStage.finishedRide;
        // TODO: Call API to mark trip as completed
        break;
      case TripProgressStage.finishedRide:
        // Trip is complete, navigate back to home
        Get.back();
        break;
    }
  }
}