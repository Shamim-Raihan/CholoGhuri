class OtpResponse {
  final bool success;
  final int code;
  final String message;
  final OtpData? data;

  OtpResponse({
    required this.success,
    required this.code,
    required this.message,
    this.data,
  });

  factory OtpResponse.fromMap(Map<String, dynamic> map) {
    return OtpResponse(
      success: map['success'] == true,
      code: map['code'] ?? 0,
      message: map['message'] ?? '',
      data:
          map['data_list'] != null
              ? OtpData.fromMap(Map<String, dynamic>.from(map['data_list']))
              : null,
    );
  }
}

class OtpData {
  final String mobileNumber;
  final String status;
  final String basicUserType;
  final dynamic userRoll;

  OtpData({
    required this.mobileNumber,
    required this.status,
    required this.basicUserType,
    this.userRoll,
  });

  factory OtpData.fromMap(Map<String, dynamic> map) {
    return OtpData(
      mobileNumber: map['mobile_number'] ?? '',
      status: map['status'] ?? '',
      basicUserType: map['basic_user_type'] ?? '',
      userRoll: map['user_roll'],
    );
  }
}
