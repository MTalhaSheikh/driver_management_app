import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/trip_info_controller.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../views/widgets/passenger_contact_card.dart';
import '../views/widgets/slide_action_button.dart';
import '../views/widgets/trip_map_preview.dart';
import '../views/widgets/trip_points_card.dart';

class TripInfoView extends StatelessWidget {
  const TripInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final TripInfoController controller = Get.find<TripInfoController>();

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
                      controller.stageTitle,
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
                        TripMapPreview(
                          onExpand: () => Get.toNamed('/map'),
                        ),
                        const SizedBox(height: 34),
                        Text(
                          controller.scheduledLabel.value,
                          style: AppTheme.tripTime,
                        ),
                        const SizedBox(height: 18),
                        TripPointsCard(
                          pickupTitle: controller.pickupTitle.value,
                          pickupSubtitle: controller.pickupSubtitle.value,
                          dropoffTitle: controller.dropoffTitle.value,
                          dropoffSubtitle: controller.dropoffSubtitle.value,
                          miles: controller.distanceMiles.value,
                          mins: controller.durationMins.value,
                        ),
                        const SizedBox(height: 27),
                        PassengerContactCard(
                          name: controller.passengerName.value,
                          phone: controller.passengerPhone.value,
                          onChat: () {},
                          onCall: () {},
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SlideActionButton(
                    label: controller.stageTitle,
                    leadingIcon: _stageIcon(controller.stage.value),
                    isLoading: controller.isUpdatingStatus.value,
                    onCompleted: () {
                      controller.advanceStage();
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

IconData _stageIcon(TripProgressStage stage) {
  switch (stage) {
    case TripProgressStage.onTheWay:
      return Icons.directions_car_filled_outlined;
    case TripProgressStage.pickPassenger:
      return Icons.location_on_outlined;
    case TripProgressStage.arrived:
      return Icons.emoji_people_outlined;
    case TripProgressStage.finishedTrip:
      return Icons.luggage_outlined;
  }
}

