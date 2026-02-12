import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              // Header with back button and title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Spacer(),
                    Text(
                      'Profile',
                      style: AppTheme.sectionTitle,
                    ),
                    const Spacer(),
                    // Refresh button
                    IconButton(
                      onPressed: controller.isLoading.value 
                        ? null 
                        : controller.refreshProfile,
                      icon: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),

              // Profile card
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: controller.refreshProfile,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              // Profile card
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.softCardShadow,
                                      blurRadius: 18,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // Profile picture with badge
                                    Stack(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF1E3A5F),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1E3A5F),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'DRIVER',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    
                                    // Name
                                    Text(
                                      controller.name.value.isNotEmpty 
                                        ? controller.name.value 
                                        : 'Driver Name',
                                      style: AppTheme.driverName,
                                    ),
                                    const SizedBox(height: 4),
                                    
                                    // Username
                                    if (controller.username.value.isNotEmpty)
                                      Text(
                                        '@${controller.username.value}',
                                        style: AppTheme.bodyMedium.copyWith(
                                          color: Colors.grey.shade600,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    
                                    const SizedBox(height: 16),
                                    const Divider(),
                                    const SizedBox(height: 16),
                                    
                                    // Contact Information
                                    _buildInfoRow(
                                      icon: Icons.email_outlined,
                                      label: 'Email',
                                      value: controller.email.value,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      icon: Icons.phone_outlined,
                                      label: 'Phone',
                                      value: controller.phone.value,
                                    ),
                                    
                                    const SizedBox(height: 16),
                                    const Divider(),
                                    const SizedBox(height: 16),
                                    
                                    // Vehicle Information Section
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.directions_car,
                                          color: AppColors.portalOlive,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Vehicle Information',
                                          style: AppTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    
                                    // Vehicle Details
                                    _buildVehicleInfo(
                                      label: 'Brand',
                                      value: controller.vehicleBrand.value,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildVehicleInfo(
                                      label: 'Model',
                                      value: controller.vehicleModel.value,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildVehicleInfo(
                                      label: 'Color',
                                      value: controller.vehicleColor.value,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildVehicleInfo(
                                      label: 'Number',
                                      value: controller.vehicleNumber.value,
                                    ),
                                    
                                    const SizedBox(height: 24),
                                    
                                    // Active Status section
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.screenBackground,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Active Status',
                                                  style: AppTheme.titleMedium,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  controller.isActive.value
                                                    ? 'Ready to receive trips'
                                                    : 'Not accepting trips',
                                                  style: AppTheme.bodyMedium.copyWith(
                                                    color: controller.isActive.value
                                                      ? Colors.green.shade700
                                                      : Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Switch(
                                            value: controller.isActive.value,
                                            onChanged: (_) => controller.toggleActiveStatus(),
                                            activeColor: AppColors.portalOlive,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
              ),

              // Logout button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: InkWell(
                  onTap: controller.logout,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppColors.portalOlive,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.portalOlive,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.portalOlive,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'Not provided',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleInfo({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value.isNotEmpty ? value : '-',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}