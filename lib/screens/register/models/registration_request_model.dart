class RegistrationRequest {
  final String name;
  final String email;
  final String mobileNo;
  final String latitude;
  final String longitude;
  final String macAddress;
  final String ipAddress;
  final String deviceType;
  final String basicUserType;
  final String country;
  final String division;
  final String district;
  final String thanaUpazila;
  final String address;

  const RegistrationRequest({
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.latitude,
    required this.longitude,
    required this.macAddress,
    required this.ipAddress,
    required this.deviceType,
    required this.basicUserType,
    required this.country,
    required this.division,
    required this.district,
    required this.thanaUpazila,
    required this.address,
  });

  Map<String, String> toQueryParams() {
    return {
      'name': name,
      'email': email,
      'mobile_no': mobileNo,
      'latitude': latitude,
      'longitude': longitude,
      'mac_address': macAddress,
      'ip_address': ipAddress,
      'device_type': deviceType,
      'basic_user_type': basicUserType,
      'country': country,
      'division': division,
      'district': district,
      'thana_upazila': thanaUpazila,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'RegistrationRequest{name: $name, email: $email, mobileNo: $mobileNo, basicUserType: $basicUserType}';
  }
}
