class TempUser {
  final int tempUserId;
  final String tempUserMobileNo;
  final String createdAt;
  final String otpExpired;
  final String otpExpiredAt;

  const TempUser({
    required this.tempUserId,
    required this.tempUserMobileNo,
    required this.createdAt,
    required this.otpExpired,
    required this.otpExpiredAt,
  });

  factory TempUser.fromJson(Map<String, dynamic> json) {
    return TempUser(
      tempUserId: json['temp_user_id'] as int,
      tempUserMobileNo: json['temp_user_mobile_no'] as String,
      createdAt: json['created_at'] as String,
      otpExpired: json['otp_expired'] as String,
      otpExpiredAt: json['otp_expired_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_user_id': tempUserId,
      'temp_user_mobile_no': tempUserMobileNo,
      'created_at': createdAt,
      'otp_expired': otpExpired,
      'otp_expired_at': otpExpiredAt,
    };
  }

  @override
  String toString() {
    return 'TempUser{tempUserId: $tempUserId, tempUserMobileNo: $tempUserMobileNo, otpExpired: $otpExpired}';
  }
}

class RegistrationResponse {
  final bool success;
  final int code;
  final String message;
  final List<String> errorMessages;
  final Map<String, List<String>> fieldErrors;
  final TempUser? data;

  const RegistrationResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.errorMessages,
    required this.fieldErrors,
    this.data,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    final parsedErrors = _parseErrorMessages(json['error_messages']);

    return RegistrationResponse(
      success: json['success'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      errorMessages: parsedErrors['messages'] ?? [],
      fieldErrors: parsedErrors['fieldErrors'] ?? {},
      data: _parseData(json['data']),
    );
  }

  static Map<String, dynamic> _parseErrorMessages(dynamic errorMessages) {
    final List<String> messages = [];
    final Map<String, List<String>> fieldErrors = {};

    if (errorMessages == null) {
      return {'messages': messages, 'fieldErrors': fieldErrors};
    }

    if (errorMessages is List) {
      messages.addAll(errorMessages.map((e) => e.toString()));
    } else if (errorMessages is Map) {
      errorMessages.forEach((key, value) {
        if (value is List) {
          final fieldErrorList = value.map((e) => e.toString()).toList();
          fieldErrors[key] = fieldErrorList;
          messages.addAll(fieldErrorList);
        } else {
          final errorStr = value.toString();
          fieldErrors[key] = [errorStr];
          messages.add(errorStr);
        }
      });
    } else {
      messages.add(errorMessages.toString());
    }

    return {'messages': messages, 'fieldErrors': fieldErrors};
  }

  static TempUser? _parseData(dynamic data) {
    if (data == null) return null;

    // Handle case where data is an empty array []
    if (data is List) {
      if (data.isEmpty) return null;
      // If array has data, take the first element
      if (data.first is Map<String, dynamic>) {
        return TempUser.fromJson(data.first as Map<String, dynamic>);
      }
      return null;
    }

    // Handle case where data is a Map (single object)
    if (data is Map<String, dynamic>) {
      return TempUser.fromJson(data);
    }

    return null;
  }

  // Helper method to check if mobile number is already taken
  bool get isMobileNumberTaken {
    return fieldErrors.containsKey('mobile_no') &&
        fieldErrors['mobile_no']!.any(
          (error) => error.toLowerCase().contains('already been taken'),
        );
  }

  // Helper method to get mobile number error message
  String? get mobileNumberError {
    if (fieldErrors.containsKey('mobile_no') &&
        fieldErrors['mobile_no']!.isNotEmpty) {
      return fieldErrors['mobile_no']!.first;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'message': message,
      'error_messages': errorMessages,
      'field_errors': fieldErrors,
      'data': data?.toJson(),
    };
  }

  @override
  String toString() {
    return 'RegistrationResponse{success: $success, code: $code, message: $message, fieldErrors: $fieldErrors}';
  }
}
