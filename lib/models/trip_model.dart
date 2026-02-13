import 'dart:math';
import 'package:intl/intl.dart';

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

class TripsResponse {
  final bool success;
  final List<TripModel> trips;

  TripsResponse({
    required this.success,
    required this.trips,
  });

  factory TripsResponse.fromJson(Map<String, dynamic> json) {
    return TripsResponse(
      success: json['success'] ?? false,
      trips: (json['trips'] as List<dynamic>?)
              ?.map((trip) => TripModel.fromJson(trip))
              .toList() ??
          [],
    );
  }
}

class CustomerModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String? email;

  CustomerModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
    };
  }

  String get fullName => '$firstName $lastName'.trim();
}

class TripModel {
  final int id;
  final String tripType;
  final String pickupLocation;
  final double pickupLat;
  final double pickupLng;
  final String dropoffLocation;
  final double dropoffLat;
  final double dropoffLng;
  final DateTime pickupDate;
  final String pickupTime;
  final String flightNumber;
  final String trackingToken;
  final String status;
  final String? notes;
  final CustomerModel? customer;

  // Legacy fields - will be removed once API is updated
  final String? passengerName;
  final int? passengerCount;
  final int? bagsCount;

  TripModel({
    required this.id,
    required this.tripType,
    required this.pickupLocation,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLocation,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.pickupDate,
    required this.pickupTime,
    required this.flightNumber,
    required this.trackingToken,
    required this.status,
    this.notes,
    this.customer,
    this.passengerName,
    this.passengerCount,
    this.bagsCount,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? 0,
      tripType: json['trip_type'] ?? '',
      pickupLocation: json['pickup_location'] ?? '',
      pickupLat: double.tryParse(json['pickup_lat']?.toString() ?? '0') ?? 0.0,
      pickupLng: double.tryParse(json['pickup_lng']?.toString() ?? '0') ?? 0.0,
      dropoffLocation: json['dropoff_location'] ?? '',
      dropoffLat: double.tryParse(json['dropoff_lat']?.toString() ?? '0') ?? 0.0,
      dropoffLng: double.tryParse(json['dropoff_lng']?.toString() ?? '0') ?? 0.0,
      pickupDate: _parseDate(json['pickup_date']),
      pickupTime: json['pickup_time'] ?? '',
      flightNumber: json['flight_number'] ?? '',
      trackingToken: json['tracking_token'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'],
      customer: json['customer'] != null 
          ? CustomerModel.fromJson(json['customer']) 
          : null,
      // Legacy fields
      passengerName: json['passenger_name'],
      passengerCount: json['passenger_count'],
      bagsCount: json['bags_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_type': tripType,
      'pickup_location': pickupLocation,
      'pickup_lat': pickupLat,
      'pickup_lng': pickupLng,
      'dropoff_location': dropoffLocation,
      'dropoff_lat': dropoffLat,
      'dropoff_lng': dropoffLng,
      'pickup_date': DateFormat('yyyy-MM-dd').format(pickupDate),
      'pickup_time': pickupTime,
      'flight_number': flightNumber,
      'tracking_token': trackingToken,
      'status': status,
      'notes': notes,
      'customer': customer?.toJson(),
      'passenger_name': passengerName,
      'passenger_count': passengerCount,
      'bags_count': bagsCount,
    };
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return DateTime.now();
    }
  }

  // Computed properties for UI

  TripStatus get tripStatus {
    // Pending: assigned and pickup is more than 1 hour away.
    // In Progress: assigned and (within 1 hour of pickup OR pickup time has passed) until API marks completed.
    if (status.toLowerCase() == 'assigned') {
      if (_isWithinOneHourOfPickup() || _isPastPickupTime()) {
        return TripStatus.inProgress;
      }
      return TripStatus.pending;
    }

    switch (status.toLowerCase()) {
      // Completed / finished states
      case 'completed':
      case 'finished':
      case 'finished_trip':
        return TripStatus.completed;

      // Explicit "in progress" style states from API
      case 'in_progress':
      case 'inprogress':
      case 'on_the_way':
      case 'arrived':
      case 'picked_up':
        return TripStatus.inProgress;

      // Canceled states
      case 'canceled':
      case 'cancelled':
        return TripStatus.canceled;

      // Explicit pending
      case 'pending':
      default:
        return TripStatus.pending;
    }
  }

  /// Pickup is within 1 hour from now (0 to 60 minutes ahead)
  bool _isWithinOneHourOfPickup() {
    try {
      final pickupDateTime = _pickupDateTime;
      if (pickupDateTime == null) return false;
      final now = DateTime.now();
      final difference = pickupDateTime.difference(now);
      return difference.inMinutes <= 60 && difference.inMinutes >= 0;
    } catch (e) {
      return false;
    }
  }

  /// Pickup date/time has passed (trip remains in progress until completed)
  bool _isPastPickupTime() {
    try {
      final pickupDateTime = _pickupDateTime;
      if (pickupDateTime == null) return false;
      return DateTime.now().isAfter(pickupDateTime);
    } catch (e) {
      return false;
    }
  }

  DateTime? get _pickupDateTime {
    try {
      final parts = pickupTime.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return DateTime(
          pickupDate.year,
          pickupDate.month,
          pickupDate.day,
          hour,
          minute,
        );
      }
    } catch (e) {}
    return null;
  }

  TripSection get section {
    // History: completed or canceled trips
    final statusLower = status.toLowerCase();
    if (statusLower == 'completed' || 
        statusLower == 'cancelled' || 
        statusLower == 'canceled') {
      return TripSection.history;
    }
    // Upcoming: all other statuses (pending, in_progress, etc.)
    return TripSection.upcoming;
  }

  String get timeLabel {
    // Parse time from pickupTime (format: "12:05:00")
    try {
      final parts = pickupTime.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
    } catch (_) {}
    return pickupTime;
  }

  String get dateLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tripDay = DateTime(pickupDate.year, pickupDate.month, pickupDate.day);
    
    if (tripDay == today) {
      return 'Today';
    } else if (tripDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (tripDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd').format(pickupDate);
    }
  }

  String get fullDateLabel {
    return DateFormat('MMM dd, yyyy').format(pickupDate);
  }

  String get scheduledLabel {
    return '$dateLabel, $timeLabel';
  }

  // Pickup location parts
  String get pickupTitle {
    final parts = pickupLocation.split(',');
    return parts.isNotEmpty ? parts[0].trim() : pickupLocation;
  }

  String get pickupSubtitle {
    final parts = pickupLocation.split(',');
    if (parts.length > 1) {
      return parts.sublist(1).join(',').trim();
    }
    return '';
  }

  // Dropoff location parts
  String get dropoffTitle {
    final parts = dropoffLocation.split(',');
    return parts.isNotEmpty ? parts[0].trim() : dropoffLocation;
  }

  String get dropoffSubtitle {
    final parts = dropoffLocation.split(',');
    if (parts.length > 1) {
      return parts.sublist(1).join(',').trim();
    }
    return '';
  }

  // Distance calculation (simple approximation)
  double get distanceMiles {
    // Haversine formula
    const R = 3959.0; // Earth's radius in miles
    final lat1 = pickupLat * pi / 180; // Convert to radians
    final lat2 = dropoffLat * pi / 180;
    final dLat = (dropoffLat - pickupLat) * pi / 180;
    final dLon = (dropoffLng - pickupLng) * pi / 180;

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * asin(sqrt(a));

    return (R * c * 10).round() / 10; // Round to 1 decimal
  }

  // Estimated duration (rough estimate: 30 mph average)
  int get durationMins {
    return (distanceMiles * 2).round(); // Roughly 2 minutes per mile
  }

  // For backward compatibility with existing UI
  int get pax => passengerCount ?? 1;
  int get bags => bagsCount ?? 0;
  
  // Display passenger/customer name (prefer customer data from API)
  String get displayPassengerName {
    if (customer != null && customer!.fullName.isNotEmpty) {
      return customer!.fullName;
    }
    return passengerName ?? 'Passenger';
  }
  
  // Display notes or default message
  String get displayNotes {
    if (notes != null && notes!.isNotEmpty) {
      return notes!;
    }
    return 'No notes';
  }
  
  // Get customer phone
  String? get customerPhone => customer?.phone;
  
  // Get customer email
  String? get customerEmail => customer?.email;
}