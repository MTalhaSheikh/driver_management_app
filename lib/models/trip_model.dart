enum TripStatus {
  pending,
  inProgress,
  completed,
  canceled,
}

enum TripSection {
  upcoming,
  history,
}

class TripModel {
  final String id;
  final TripSection section;
  final TripStatus status;

  final String timeLabel; // e.g. "10:00 AM"
  final String dateLabel; // e.g. "Oct 24"

  final String pickupTitle;
  final String pickupSubtitle;
  final String dropoffTitle;
  final String dropoffSubtitle;

  final int pax;
  final int bags;
  final String passengerName;

  TripModel({
    required this.id,
    required this.section,
    required this.status,
    required this.timeLabel,
    required this.dateLabel,
    required this.pickupTitle,
    required this.pickupSubtitle,
    required this.dropoffTitle,
    required this.dropoffSubtitle,
    required this.pax,
    required this.bags,
    required this.passengerName,
  });
}

