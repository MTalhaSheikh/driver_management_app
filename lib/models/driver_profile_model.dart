class DriverProfile {
  final bool success;
  final DriverDetails driver;

  DriverProfile({
    required this.success,
    required this.driver,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    return DriverProfile(
      success: json['success'] ?? false,
      driver: DriverDetails.fromJson(json['driver'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'driver': driver.toJson(),
    };
  }
}

class DriverDetails {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String vehicleBrand;
  final String vehicleModel;
  final String vehicleColor;
  final String vehicleNumber;

  DriverDetails({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.vehicleNumber,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) {
    return DriverDetails(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      vehicleBrand: json['vehicle_brand'] ?? '',
      vehicleModel: json['vehicle_model'] ?? '',
      vehicleColor: json['vehicle_color'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'vehicle_brand': vehicleBrand,
      'vehicle_model': vehicleModel,
      'vehicle_color': vehicleColor,
      'vehicle_number': vehicleNumber,
    };
  }

  /// Get formatted vehicle info
  String get vehicleInfo => '$vehicleBrand $vehicleModel';
  
  /// Get formatted vehicle details
  String get vehicleFullInfo => '$vehicleBrand $vehicleModel ($vehicleColor) - $vehicleNumber';
}