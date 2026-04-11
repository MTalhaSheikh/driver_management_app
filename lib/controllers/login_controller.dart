import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../services/location_update_service.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();

  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var driverId = 0.obs;
  var driverName = ''.obs;
  var driverPhone = ''.obs;
  var authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkSavedCredentials();
  }

  Future<void> _checkSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString('auth_token');
      if (savedToken != null && savedToken.isNotEmpty) {
        authToken.value = savedToken;
        driverId.value = prefs.getInt('driver_id') ?? 0;
        driverName.value = prefs.getString('driver_name') ?? '';
        driverPhone.value = prefs.getString('driver_phone') ?? '';
      }
    } catch (e) {
      print('Error checking saved credentials: $e');
    }
  }

  Future<void> login() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.login(
        username: email.value.trim(),
        password: password.value.trim(),
      );

      if (response.success) {
        authToken.value = response.token;
        driverId.value = response.driver.id;
        driverName.value = response.driver.name;
        driverPhone.value = response.driver.phone;
        await _saveCredentials(response);
        Get.offAllNamed(AppRoutes.home);
        Get.snackbar(
          'Success',
          'Welcome back, ${response.driver.name}!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        errorMessage.value = 'Login failed. Please try again.';
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred. Please try again.';
      print('Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveCredentials(dynamic response) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', authToken.value);
      await prefs.setInt('driver_id', driverId.value);
      await prefs.setString('driver_name', driverName.value);
      await prefs.setString('driver_phone', driverPhone.value);
    } catch (e) {
      print('Error saving credentials: $e');
    }
  }

  /// Called by any controller when the API returns 401 (token invalidated
  /// because the driver logged in on another device).
  /// Clears local session and redirects to login with a message.
  Future<void> forceLogout() async {
    // Clear location tracking
    try {
      await Get.find<LocationUpdateService>().stop();
    } catch (_) {}

    // Clear persisted data
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (_) {}

    // Clear in-memory state
    email.value = '';
    password.value = '';
    authToken.value = '';
    driverId.value = 0;
    driverName.value = '';
    driverPhone.value = '';
    errorMessage.value = '';

    // Navigate to login
    Get.offAllNamed(AppRoutes.login);

    Get.snackbar(
      'Logged Out',
      'Your account was signed in on another device.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade100,
      colorText: Colors.orange.shade900,
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.devices, color: Colors.orange),
    );
  }

  /// Manual logout (user-initiated)
  Future<void> logout() async {
    try {
      isLoading.value = true;

      try {
        await Get.find<LocationUpdateService>().stop();
      } catch (_) {}

      if (authToken.value.isNotEmpty) {
        try {
          await _apiService.logout(token: authToken.value);
        } on ApiException catch (e) {
          print('Logout API error: ${e.message}');
        }
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      email.value = '';
      password.value = '';
      authToken.value = '';
      driverId.value = 0;
      driverName.value = '';
      driverPhone.value = '';
      errorMessage.value = '';

      Get.offAllNamed(AppRoutes.login);

      Get.snackbar(
        'Logged Out',
        'You have been successfully logged out',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error during logout: $e');
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoading.value = false;
    }
  }

  bool get isAuthenticated => authToken.value.isNotEmpty;
}
