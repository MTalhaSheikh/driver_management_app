import 'package:get/get.dart';

enum TripProgressStage {
  onTheWay,
  pickPassenger,
  arrived,
  finishedRide,
}

class TripInfoController extends GetxController {
  final RxString currentTripId = ''.obs;
  final RxString pickupTitle = 'Heathrow Terminal 5'.obs;
  final RxString pickupSubtitle = 'London, TW6 2GA'.obs;
  final RxString dropoffTitle = 'The Savoy Hotel'.obs;
  final RxString dropoffSubtitle = 'Strand, London WC2R 0EU'.obs;

  final RxString scheduledLabel = 'Today, 10:30 AM'.obs;
  final RxDouble distanceMiles = 18.4.obs;
  final RxInt durationMins = 45.obs;

  final RxString passengerName = 'James Anderson'.obs;
  final RxString passengerPhone = '+128846261841'.obs;

  final Rx<TripProgressStage> stage = TripProgressStage.onTheWay.obs;

  String get stageTitle {
    switch (stage.value) {
      case TripProgressStage.onTheWay:
        return 'On The Way';
      case TripProgressStage.pickPassenger:
        return 'Pick Passenger';
      case TripProgressStage.arrived:
        return 'Arrived';
      case TripProgressStage.finishedRide:
        return 'Finished Ride';
    }
  }

  void advanceStage() {
    switch (stage.value) {
      case TripProgressStage.onTheWay:
        stage.value = TripProgressStage.pickPassenger;
        break;
      case TripProgressStage.pickPassenger:
        stage.value = TripProgressStage.arrived;
        break;
      case TripProgressStage.arrived:
        stage.value = TripProgressStage.finishedRide;
        break;
      case TripProgressStage.finishedRide:
        // no-op
        break;
    }
  }
}

