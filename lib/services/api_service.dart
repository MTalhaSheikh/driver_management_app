// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:limo_guy/views/login/login_response';
// import '../models/driver_profile_model.dart';

// class ApiService {
//   // Update this with your actual API base URL
//   static const String baseUrl = 'https://dash.mayfairlimo.ca/api';
  
//   /// Login endpoint
//   Future<LoginResponse> login({
//     required String username,
//     required String password,
//   }) async {
//     try {
//       final url = Uri.parse('$baseUrl/driver/login');
      
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'username': username,
//           'password': password,
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return LoginResponse.fromJson(jsonData);
//       } else {
//         // Handle error responses
//         final jsonData = json.decode(response.body);
//         throw ApiException(
//           message: jsonData['message'] ?? 'Login failed',
//           statusCode: response.statusCode,
//         );
//       }
//     } catch (e) {
//       if (e is ApiException) {
//         rethrow;
//       }
//       throw ApiException(
//         message: 'Network error: ${e.toString()}',
//         statusCode: 0,
//       );
//     }
//   }

//   /// Logout endpoint
//   Future<bool> logout({required String token}) async {
//     try {
//       final url = Uri.parse('$baseUrl/driver/logout');
      
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return jsonData['success'] ?? false;
//       } else if (response.statusCode == 401) {
//         // Unauthorized - token is invalid or expired
//         throw ApiException(
//           message: 'Invalid token',
//           statusCode: response.statusCode,
//         );
//       } else {
//         // Handle other error responses
//         final jsonData = json.decode(response.body);
//         throw ApiException(
//           message: jsonData['message'] ?? 'Logout failed',
//           statusCode: response.statusCode,
//         );
//       }
//     } catch (e) {
//       if (e is ApiException) {
//         rethrow;
//       }
//       throw ApiException(
//         message: 'Network error: ${e.toString()}',
//         statusCode: 0,
//       );
//     }
//   }

//   /// Get driver profile endpoint
//   Future<DriverProfile> getProfile({required String token}) async {
//     try {
//       final url = Uri.parse('$baseUrl/driver/profile');
      
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return DriverProfile.fromJson(jsonData);
//       } else if (response.statusCode == 401) {
//         // Unauthorized - token is invalid or expired
//         throw ApiException(
//           message: 'Invalid token',
//           statusCode: response.statusCode,
//         );
//       } else {
//         // Handle other error responses
//         final jsonData = json.decode(response.body);
//         throw ApiException(
//           message: jsonData['message'] ?? 'Failed to fetch profile',
//           statusCode: response.statusCode,
//         );
//       }
//     } catch (e) {
//       if (e is ApiException) {
//         rethrow;
//       }
//       throw ApiException(
//         message: 'Network error: ${e.toString()}',
//         statusCode: 0,
//       );
//     }
//   }
// }

// /// Custom exception for API errors
// class ApiException implements Exception {
//   final String message;
//   final int statusCode;

//   ApiException({
//     required this.message,
//     required this.statusCode,
//   });

//   @override
//   String toString() => message;
// }



















import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:limo_guy/views/login/login_response';
import '../models/driver_profile_model.dart';
import '../models/trip_model.dart';

class ApiService {
  // Update this with your actual API base URL
  static const String baseUrl = 'https://dash.mayfairlimo.ca/api';
  
  /// Login endpoint
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/driver/login');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return LoginResponse.fromJson(jsonData);
      } else {
        // Handle error responses
        final jsonData = json.decode(response.body);
        throw ApiException(
          message: jsonData['message'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Logout endpoint
  Future<bool> logout({required String token}) async {
    try {
      final url = Uri.parse('$baseUrl/driver/logout');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['success'] ?? false;
      } else if (response.statusCode == 401) {
        // Unauthorized - token is invalid or expired
        throw ApiException(
          message: 'Invalid token',
          statusCode: response.statusCode,
        );
      } else {
        // Handle other error responses
        final jsonData = json.decode(response.body);
        throw ApiException(
          message: jsonData['message'] ?? 'Logout failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Get driver profile endpoint
  Future<DriverProfile> getProfile({required String token}) async {
    try {
      final url = Uri.parse('$baseUrl/driver/profile');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return DriverProfile.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        // Unauthorized - token is invalid or expired
        throw ApiException(
          message: 'Invalid token',
          statusCode: response.statusCode,
        );
      } else {
        // Handle other error responses
        final jsonData = json.decode(response.body);
        throw ApiException(
          message: jsonData['message'] ?? 'Failed to fetch profile',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  /// Get driver trips endpoint
  Future<TripsResponse> getTrips({required String token}) async {
    try {
      final url = Uri.parse('$baseUrl/driver/trips');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return TripsResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        // Unauthorized - token is invalid or expired
        throw ApiException(
          message: 'Invalid token',
          statusCode: response.statusCode,
        );
      } else {
        // Handle other error responses
        final jsonData = json.decode(response.body);
        throw ApiException(
          message: jsonData['message'] ?? 'Failed to fetch trips',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => message;
}