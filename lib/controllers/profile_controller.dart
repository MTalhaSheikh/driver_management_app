import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../services/api_service.dart';
import '../models/driver_profile_model.dart';

class ProfileController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // Lazy getter to access LoginController when needed
  LoginController get _loginController => Get.find<LoginController>();

  // Observable profile data
  var name = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var vehicleBrand = ''.obs;
  var vehicleModel = ''.obs;
  var vehicleColor = ''.obs;
  var vehicleNumber = ''.obs;
  var isActive = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
  }

  /// Load profile data from API
  Future<void> _loadProfileData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get token from LoginController
      final token = _loginController.authToken.value;
      
      if (token.isEmpty) {
        throw Exception('No authentication token found');
      }

      // Fetch profile from API
      final profileResponse = await _apiService.getProfile(token: token);

      if (profileResponse.success) {
        // Update observable values with API data
        username.value = profileResponse.driver.username;
        name.value = profileResponse.driver.name;
        email.value = profileResponse.driver.email;
        phone.value = profileResponse.driver.phone;
        vehicleBrand.value = profileResponse.driver.vehicleBrand;
        vehicleModel.value = profileResponse.driver.vehicleModel;
        vehicleColor.value = profileResponse.driver.vehicleColor;
        vehicleNumber.value = profileResponse.driver.vehicleNumber;
      } else {
        throw Exception('Failed to load profile');
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      // Fallback to LoginController data if available
      _loadFromLoginController();
      
      Get.snackbar(
        'Error',
        'Failed to load profile: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } catch (e) {
      errorMessage.value = 'An error occurred while loading profile';
      // Fallback to LoginController data if available
      _loadFromLoginController();
      
      print('Error loading profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fallback: Load basic data from LoginController
  void _loadFromLoginController() {
    try {
      name.value = _loginController.driverName.value;
      email.value = _loginController.email.value;
      phone.value = _loginController.driverPhone.value;
    } catch (e) {
      print('Error loading from LoginController: $e');
    }
  }

  /// Refresh profile data
  Future<void> refreshProfile() async {
    await _loadProfileData();
  }

  /// Toggle active status
  void toggleActiveStatus() {
    isActive.value = !isActive.value;
    
    // TODO: Call API to update active status on server
    // await _apiService.updateActiveStatus(isActive.value);
    
    Get.snackbar(
      'Status Updated',
      isActive.value 
        ? 'You are now active and can receive trips' 
        : 'You are now inactive',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Logout - delegates to LoginController
  Future<void> logout() async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _loginController.logout();
    }
  }

  /// Get formatted vehicle info
  String get vehicleInfo {
    if (vehicleBrand.value.isEmpty && vehicleModel.value.isEmpty) {
      return 'No vehicle assigned';
    }
    return '${vehicleBrand.value} ${vehicleModel.value}'.trim();
  }

  /// Get formatted vehicle details
  String get vehicleFullInfo {
    if (vehicleBrand.value.isEmpty) return 'No vehicle assigned';
    return '${vehicleBrand.value} ${vehicleModel.value} (${vehicleColor.value}) - ${vehicleNumber.value}';
  }
}