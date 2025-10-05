class OtpVerificationData {
  final String token;
  final String name;

  const OtpVerificationData({required this.token, required this.name});

  factory OtpVerificationData.fromJson(Map<String, dynamic> json) {
    return OtpVerificationData(
      token: json['token'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'name': name};
  }

  @override
  String toString() {
    return 'OtpVerificationData{token: $token, name: $name}';
  }
}

class OtpVerificationResponse {
  final bool success;
  final int code;
  final String message;
  final List<String> errorMessages;
  final OtpVerificationData? data;

  const OtpVerificationResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.errorMessages,
    this.data,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      success: json['success'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      errorMessages:
          (json['error_messages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      data:
          json['data'] != null
              ? OtpVerificationData.fromJson(
                json['data'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'message': message,
      'error_messages': errorMessages,
      'data': data?.toJson(),
    };
  }

  @override
  String toString() {
    return 'OtpVerificationResponse{success: $success, code: $code, message: $message, data: $data}';
  }
}
