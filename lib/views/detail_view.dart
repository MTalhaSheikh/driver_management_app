import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import 'widgets/trip_map_preview.dart';
import 'widgets/trip_points_card.dart';
import 'widgets/passenger_contact_card.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController controller = Get.find<DetailController>();

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

                // AppBar (custom)
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Spacer(),
                    Text(
                      'Trip Details',
                      style: AppTheme.sectionTitle,
                    ),
                    const Spacer(),
                    const SizedBox(width: 48), // balance back button
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Map preview
                        TripMapPreview(
                          onExpand: () => Get.toNamed('/map'),
                        ),
                        const SizedBox(height: 34),

                        // Date and time
                        Text(
                          controller.scheduledLabel.value,
                          style: AppTheme.tripTime,
                        ),
                        const SizedBox(height: 18),

                        // Trip points card
                        TripPointsCard(
                          pickupTitle: controller.pickupTitle.value,
                          pickupSubtitle: controller.pickupSubtitle.value,
                          dropoffTitle: controller.dropoffTitle.value,
                          dropoffSubtitle: controller.dropoffSubtitle.value,
                          miles: controller.distanceMiles.value,
                          mins: controller.durationMins.value,
                        ),
                        const SizedBox(height: 27),

                        // Driver contact card
                        PassengerContactCard(
                          name: controller.driverName.value,
                          phone: controller.driverPhone.value,
                          onChat: () {
                            // Handle chat action
                          },
                          onCall: () {
                            // Handle call action
                          },
                        ),
                        const SizedBox(height: 22),
                      ],
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
