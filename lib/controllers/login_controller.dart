import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../services/location_update_service.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // Observable variables
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  
  // Store user data
  var driverId = 0.obs;
  var driverName = ''.obs;
  var driverPhone = ''.obs;
  var authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkSavedCredentials();
  }

  /// Restore saved login state (no navigation — Splash handles that after delay)
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

  /// Login function
  Future<void> login() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Call API
      final response = await _apiService.login(
        username: email.value.trim(),
        password: password.value.trim(),
      );

      if (response.success) {
        // Save token and user data
        authToken.value = response.token;
        driverId.value = response.driver.id;
        driverName.value = response.driver.name;
        driverPhone.value = response.driver.phone;

        // Persist to SharedPreferences
        await _saveCredentials(response);

        // Navigate to home
        Get.offAllNamed(AppRoutes.home);
        
        // Show success message
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

  /// Save credentials to SharedPreferences
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

  /// Logout function
  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      // Stop tracking (e.g., on logout)
      try {
        await Get.find<LocationUpdateService>().stop();
      } catch (_) {}

      // Call logout API if user has a token
      if (authToken.value.isNotEmpty) {
        try {
          await _apiService.logout(token: authToken.value);
        } on ApiException catch (e) {
          // Log the error but continue with local logout
          print('Logout API error: ${e.message}');
          // Still proceed with local cleanup even if API call fails
        }
      }

      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      // Clear observable values
      email.value = '';
      password.value = '';
      authToken.value = '';
      driverId.value = 0;
      driverName.value = '';
      driverPhone.value = '';
      errorMessage.value = '';
      
      // Navigate to login
      Get.offAllNamed(AppRoutes.login);
      
      // Show logout message
      Get.snackbar(
        'Logged Out',
        'You have been successfully logged out',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error during logout: $e');
      // Even if there's an error, try to navigate to login
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => authToken.value.isNotEmpty;
}