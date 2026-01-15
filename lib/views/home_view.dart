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
                      child:
                          Icon(Icons.person, color: Colors.black54, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.welcomeBack,
                          style: AppTheme.welcomeSubtitle,
                        ),
                        Text(
                          controller.driverName.value,
                          style: AppTheme.driverName,
                        ),
                      ],
                    ),
                    const Spacer(),
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

                // Section title row (Today — Oct 24)
                Row(
                  children: [
                    Text(
                      AppTexts.today,
                      style: AppTheme.sectionTitle,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Divider(color: AppColors.divider, height: 1),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _dateLabel(controller),
                      style: AppTheme.dateLabel,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Trip list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: controller.visibleTrips.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final trip = controller.visibleTrips[index];
                      final highlighted =
                          controller.section.value == TripSection.upcoming &&
                              trip.status == TripStatus.inProgress &&
                              index == 0;

                      return TripCard(
                        trip: trip,
                        highlighted: highlighted,
                        onDetails: () => Get.toNamed('/map'),
                        onNavigate: () => Get.toNamed('/trip-info'),
                      );
                    },
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

String _dateLabel(HomeController controller) {
  final trips = controller.visibleTrips;
  if (trips.isEmpty) return '';
  return trips.first.dateLabel;
}
