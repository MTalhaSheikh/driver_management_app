import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/login_controller.dart';
import '../models/trip_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();
  LoginController get _loginController => Get.find<LoginController>();

  // Header
  final RxString driverName = ''.obs;

  // Switch: Upcoming / History
  final Rx<TripSection> section = TripSection.upcoming.obs;

  // Filter chips depend on section
  final RxString filter = 'All'.obs;

  // Date selection: null = show all trips with their dates; non-null = filter by that day
  // Initialize to null so by default all trips are shown
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Trips data from API
  final RxList<TripModel> trips = <TripModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  List<String> get availableFilters {
    if (section.value == TripSection.upcoming) {
      return const ['All', 'In Progress', 'Pending'];
    }
    return const ['All', 'Completed', 'Canceled'];
  }

  @override
  void onInit() {
    super.onInit();
    _loadDriverName();
    _loadTrips();
  }

  /// Load driver name from LoginController
  void _loadDriverName() {
    try {
      driverName.value = _loginController.driverName.value;
      if (driverName.value.isEmpty) {
        driverName.value = 'Driver';
      }
    } catch (e) {
      driverName.value = 'Driver';
    }
  }

  /// Load trips from API
  Future<void> _loadTrips() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get token from LoginController
      final token = _loginController.authToken.value;
      
      if (token.isEmpty) {
        throw Exception('No authentication token found');
      }

      // Fetch trips from API
      final tripsResponse = await _apiService.getTrips(token: token);

      if (tripsResponse.success) {
        trips.value = tripsResponse.trips;
      } else {
        throw Exception('Failed to load trips');
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar(
        'Error',
        'Failed to load trips: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } catch (e) {
      errorMessage.value = 'An error occurred while loading trips';
      print('Error loading trips: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh trips
  Future<void> refreshTrips() async {
    await _loadTrips();
  }

  void setSection(TripSection value) {
    section.value = value;
    filter.value = 'All';
  }

  void setFilter(String value) {
    filter.value = value;
  }

  /// Show date picker and filter trips
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF7C8D3C), // AppColors.portalOlive
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  /// Clear date filter — show all trips with their dates
  void clearDateFilter() {
    selectedDate.value = null;
  }

  /// True when no date filter is applied (showing all trips)
  bool get isDateFilterCleared => selectedDate.value == null;

  /// Get visible trips based on section, filter, and selected date
  List<TripModel> get visibleTrips {
    // Filter by section (upcoming/history)
    var filtered = trips.where((t) => t.section == section.value).toList();

    // Filter by date when a date is selected; when cleared (null) show all trips
    final selected = selectedDate.value;
    if (selected != null) {
      final selectedDay = DateTime(selected.year, selected.month, selected.day);
      filtered = filtered.where((t) {
        final tripDay = DateTime(
          t.pickupDate.year,
          t.pickupDate.month,
          t.pickupDate.day,
        );
        return tripDay == selectedDay;
      }).toList();
    }

    // Filter by status
    if (filter.value != 'All') {
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
      if (status != null) {
        filtered = filtered.where((t) => t.tripStatus == status).toList();
      }
    }

    // Sort trips:
    // When showing all dates: by pickup date then time; otherwise by status then time
    filtered.sort((a, b) {
      if (selected == null) {
        // All-dates mode: sort by date first, then time
        final aDate = DateTime(a.pickupDate.year, a.pickupDate.month, a.pickupDate.day);
        final bDate = DateTime(b.pickupDate.year, b.pickupDate.month, b.pickupDate.day);
        final dateCompare = aDate.compareTo(bDate);
        if (dateCompare != 0) return dateCompare;
      } else {
        // Single-day mode: priority by status then time
        final aPriority = _getStatusPriority(a.tripStatus);
        final bPriority = _getStatusPriority(b.tripStatus);
        if (aPriority != bPriority) {
          return aPriority.compareTo(bPriority);
        }
      }
      return a.pickupTime.compareTo(b.pickupTime);
    });

    return filtered;
  }

  /// Get priority for sorting (lower number = higher priority)
  int _getStatusPriority(TripStatus status) {
    switch (status) {
      case TripStatus.inProgress:
        return 0; // Highest priority
      case TripStatus.pending:
        return 1; // Second priority
      case TripStatus.completed:
        return 2;
      case TripStatus.canceled:
        return 3;
    }
  }

  /// Get formatted date label for display (e.g. "All dates", "Today", "Feb 12")
  String get dateDisplayLabel {
    final selected = selectedDate.value;
    if (selected == null) return 'All dates';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(selected.year, selected.month, selected.day);

    if (selectedDay == today) {
      return 'Today';
    } else if (selectedDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (selectedDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd').format(selected);
    }
  }

  /// Navigate to trip details
  void navigateToDetails(TripModel trip) {
    Get.toNamed('/detail', arguments: trip);
  }

  /// Navigate to trip info (for in-progress trips)
  void navigateToTripInfo(TripModel trip) {
    Get.toNamed('/trip-info', arguments: trip);
  }
}