import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../core/app_colors.dart';
import '../core/app_texts.dart';
import '../core/app_theme.dart';
import '../models/trip_model.dart';
import 'widgets/home_filter_tabs.dart';
import 'widgets/home_segmented_switch.dart';
import 'widgets/trip_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Header
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFE5E7EB),
                      child: Icon(Icons.person, color: Colors.black54, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.welcomeBack,
                            style: AppTheme.welcomeSubtitle,
                          ),
                          Text(
                            controller.driverName.value.isNotEmpty
                                ? controller.driverName.value
                                : 'Driver',
                            style: AppTheme.driverName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Refresh button
                    IconButton(
                      onPressed: controller.isLoading.value 
                        ? null 
                        : controller.refreshTrips,
                      icon: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                    ),
                    IconButton(
                      onPressed: () => Get.toNamed('/profile'),
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Upcoming / History switch
                HomeSegmentedSwitch(
                  leftLabel: AppTexts.upcoming,
                  rightLabel: AppTexts.history,
                  isLeftSelected: controller.section.value == TripSection.upcoming,
                  onLeftTap: () => controller.setSection(TripSection.upcoming),
                  onRightTap: () => controller.setSection(TripSection.history),
                ),

                const SizedBox(height: 12),

                // Filter tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: HomeFilterTabs(
                    items: controller.availableFilters,
                    selected: controller.filter.value,
                    onChanged: controller.setFilter,
                  ),
                ),

                const SizedBox(height: 18),

                // Section title row with date picker
                Row(
                  children: [
                    Obx(() {
                      final hasDateFilter = controller.selectedDate.value != null;
                      return GestureDetector(
                        onTap: () => controller.selectDate(context),
                        child: Row(
                          children: [
                            Text(
                              controller.dateDisplayLabel,
                              style: AppTheme.sectionTitle,
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              hasDateFilter ? Icons.calendar_today : Icons.calendar_today_outlined,
                              size: 16,
                              color: AppColors.portalOlive,
                            ),
                          ],
                        ),
                      );
                    }),
                    // Clear date filter (show when a date is selected so user can show all trips)
                    Obx(() {
                      if (controller.selectedDate.value != null) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: GestureDetector(
                            onTap: controller.clearDateFilter,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Clear',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Divider(color: AppColors.divider, height: 1),
                    ),
                    if (controller.visibleTrips.isNotEmpty &&
                        controller.selectedDate.value != null) ...[
                      const SizedBox(width: 16),
                      Text(
                        controller.visibleTrips.first.fullDateLabel,
                        style: AppTheme.dateLabel,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 14),

                // Trip list
                Expanded(
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.visibleTrips.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_busy,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    controller.selectedDate.value == null
                                        ? 'No trips'
                                        : 'No trips for ${controller.dateDisplayLabel.toLowerCase()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton.icon(
                                    onPressed: () => controller.selectDate(context),
                                    icon: const Icon(Icons.calendar_today),
                                    label: const Text('Select different date'),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: controller.refreshTrips,
                              child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 20),
                                itemCount: controller.visibleTrips.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 18),
                                itemBuilder: (context, index) {
                                  final trip = controller.visibleTrips[index];
                                  // Highlight if it's an upcoming in-progress trip
                                  final highlighted =
                                      controller.section.value == TripSection.upcoming &&
                                          trip.tripStatus == TripStatus.inProgress &&
                                          index == 0;

                                  return TripCard(
                                    trip: trip,
                                    highlighted: highlighted,
                                    showDateOnCard: controller.isDateFilterCleared,
                                    onDetails: () => controller.navigateToDetails(trip),
                                    onNavigate: () => controller.navigateToTripInfo(trip),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}