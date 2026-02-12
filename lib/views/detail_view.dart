// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/detail_controller.dart';
// import '../core/app_colors.dart';
// import '../core/app_theme.dart';
// import 'widgets/trip_map_preview.dart';
// import 'widgets/trip_points_card.dart';
// import 'widgets/passenger_contact_card.dart';

// class DetailView extends StatelessWidget {
//   const DetailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DetailController controller = Get.find<DetailController>();

//     return Scaffold(
//       backgroundColor: AppColors.screenBackground,
//       body: SafeArea(
//         child: Obx(
//           () => Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 10),

//                 // AppBar (custom)
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () => Get.back(),
//                       icon: const Icon(Icons.arrow_back),
//                     ),
//                     const Spacer(),
//                     Text(
//                       'Trip Details',
//                       style: AppTheme.sectionTitle,
//                     ),
//                     const Spacer(),
//                     const SizedBox(width: 48), // balance back button
//                   ],
//                 ),

//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.only(bottom: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Map preview
//                         TripMapPreview(
//                           onExpand: () => Get.toNamed('/map', arguments: controller.trip),
//                         ),
//                         const SizedBox(height: 34),

//                         // Date and time
//                         Text(
//                           controller.scheduledLabel.value,
//                           style: AppTheme.tripTime,
//                         ),
//                         const SizedBox(height: 18),

//                         // Trip points card
//                         TripPointsCard(
//                           pickupTitle: controller.pickupTitle.value,
//                           pickupSubtitle: controller.pickupSubtitle.value,
//                           dropoffTitle: controller.dropoffTitle.value,
//                           dropoffSubtitle: controller.dropoffSubtitle.value,
//                           miles: controller.distanceMiles.value,
//                           mins: controller.durationMins.value,
//                         ),
//                         const SizedBox(height: 27),

//                         // Customer contact card (using PassengerContactCard)
//                         PassengerContactCard(
//                           name: controller.customerName.value,
//                           phone: controller.customerPhone.value,
//                           onChat: () {
//                             // Handle chat action
//                             Get.snackbar(
//                               'Chat',
//                               'Opening chat with ${controller.customerName.value}',
//                               snackPosition: SnackPosition.BOTTOM,
//                             );
//                           },
//                           onCall: () {
//                             // Handle call action
//                             Get.snackbar(
//                               'Call',
//                               'Calling ${controller.customerPhone.value}',
//                               snackPosition: SnackPosition.BOTTOM,
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 22),

//                         // Flight Number Card
//                         if (controller.flightNumber.value.isNotEmpty)
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: AppColors.pillShadow,
//                                   blurRadius: 12,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.portalOlive.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Icon(
//                                     Icons.flight_outlined,
//                                     color: AppColors.portalOlive,
//                                     size: 24,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Flight Number',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: AppColors.textSecondary,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       controller.flightNumber.value,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w700,
//                                         color: AppColors.textPrimary,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
                        
//                         if (controller.flightNumber.value.isNotEmpty)
//                           const SizedBox(height: 22),

//                         // Notes Card
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: AppColors.pillShadow,
//                                 blurRadius: 12,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       color: Colors.amber.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: const Icon(
//                                       Icons.note_outlined,
//                                       color: Colors.amber,
//                                       size: 24,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Text(
//                                     'Notes',
//                                     style: AppTheme.titleMedium,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 controller.notes.value,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: controller.notes.value == 'No notes'
//                                       ? AppColors.textSecondary
//                                       : AppColors.textPrimary,
//                                   fontStyle: controller.notes.value == 'No notes'
//                                       ? FontStyle.italic
//                                       : FontStyle.normal,
//                                   height: 1.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




















import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../models/trip_model.dart';
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
                          onExpand: () => Get.toNamed('/map', arguments: controller.trip),
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

                        // Customer contact card (only show for in-progress trips)
                        if (controller.trip.tripStatus == TripStatus.inProgress)
                          PassengerContactCard(
                            name: controller.customerName.value,
                            phone: controller.customerPhone.value,
                            onChat: () {
                              // Handle chat action
                              Get.snackbar(
                                'Chat',
                                'Opening chat with ${controller.customerName.value}',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            onCall: () {
                              // Handle call action
                              Get.snackbar(
                                'Call',
                                'Calling ${controller.customerPhone.value}',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                          ),

                        if (controller.trip.tripStatus == TripStatus.inProgress)
                          const SizedBox(height: 22),

                        // Flight Number Card
                        if (controller.flightNumber.value.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.pillShadow,
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.portalOlive.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.flight_outlined,
                                    color: AppColors.portalOlive,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flight Number',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.flightNumber.value,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        
                        if (controller.flightNumber.value.isNotEmpty)
                          const SizedBox(height: 22),

                        // Notes Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.pillShadow,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.note_outlined,
                                      color: Colors.amber,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Notes',
                                    style: AppTheme.titleMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                controller.notes.value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.notes.value == 'No notes'
                                      ? AppColors.textSecondary
                                      : AppColors.textPrimary,
                                  fontStyle: controller.notes.value == 'No notes'
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
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