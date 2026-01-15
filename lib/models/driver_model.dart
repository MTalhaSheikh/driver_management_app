class DriverModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String licenseNumber;
  final bool isActive;

  DriverModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.licenseNumber,
    required this.isActive,
  });

  // Convert from JSON
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'licenseNumber': licenseNumber,
      'isActive': isActive,
    };
  }

  // Create a copy with updated fields
  DriverModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? licenseNumber,
    bool? isActive,
  }) {
    return DriverModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      isActive: isActive ?? this.isActive,
    );
  }
}
