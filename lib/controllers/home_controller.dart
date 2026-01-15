import 'package:get/get.dart';
import '../models/trip_model.dart';

class HomeController extends GetxController {
  // Header
  final RxString driverName = 'Michael D.'.obs;

  // Switch: Upcoming / History
  final Rx<TripSection> section = TripSection.upcoming.obs;

  // Filter chips depend on section
  final RxString filter = 'All'.obs;

  // Trips data (mock)
  final RxList<TripModel> trips = <TripModel>[].obs;

  List<String> get availableFilters {
    if (section.value == TripSection.upcoming) {
      return const ['All', 'Pending', 'In Progress'];
    }
    return const ['All', 'Completed', 'Canceled'];
  }

  @override
  void onInit() {
    super.onInit();
    _seedTrips();
  }

  void setSection(TripSection value) {
    section.value = value;
    filter.value = 'All';
  }

  void setFilter(String value) {
    filter.value = value;
  }

  List<TripModel> get visibleTrips {
    final base = trips.where((t) => t.section == section.value).toList();
    if (filter.value == 'All') return base;

    TripStatus? status;
    switch (filter.value) {
      case 'Pending':
        status = TripStatus.pending;
        break;
      case 'In Progress':
        status = TripStatus.inProgress;
        break;
      case 'Completed':
        status = TripStatus.completed;
        break;
      case 'Canceled':
        status = TripStatus.canceled;
        break;
    }
    if (status == null) return base;
    return base.where((t) => t.status == status).toList();
  }

  void _seedTrips() {
    trips.value = [
      TripModel(
        id: 't1',
        section: TripSection.upcoming,
        status: TripStatus.inProgress,
        timeLabel: '10:00 AM',
        dateLabel: 'Oct 24',
        pickupTitle: 'JFK Terminal 4',
        pickupSubtitle: 'Queens, NY 11430',
        dropoffTitle: 'Times Square Hotel',
        dropoffSubtitle: '7th Ave, New York, NY',
        pax: 4,
        bags: 2,
        passengerName: 'Jane Smith',
      ),
      TripModel(
        id: 't2',
        section: TripSection.upcoming,
        status: TripStatus.pending,
        timeLabel: '02:30 PM',
        dateLabel: 'Oct 24',
        pickupTitle: '5th Avenue Store',
        pickupSubtitle: 'Manhattan, NY',
        dropoffTitle: 'Newark Airport (EWR)',
        dropoffSubtitle: 'Terminal C',
        pax: 2,
        bags: 1,
        passengerName: 'Jane Smith',
      ),
      TripModel(
        id: 't3',
        section: TripSection.history,
        status: TripStatus.canceled,
        timeLabel: '02:30 PM',
        dateLabel: 'Oct 21',
        pickupTitle: '5th Avenue Store',
        pickupSubtitle: 'Manhattan, NY',
        dropoffTitle: 'Newark Airport (EWR)',
        dropoffSubtitle: 'Terminal C',
        pax: 1,
        bags: 0,
        passengerName: 'Jane Smith',
      ),
      TripModel(
        id: 't4',
        section: TripSection.history,
        status: TripStatus.completed,
        timeLabel: '02:30 PM',
        dateLabel: 'Oct 20',
        pickupTitle: '5th Avenue Store',
        pickupSubtitle: 'Manhattan, NY',
        dropoffTitle: 'Newark Airport (EWR)',
        dropoffSubtitle: 'Terminal C',
        pax: 2,
        bags: 1,
        passengerName: 'Jane Smith',
      ),
    ];
  }
}
