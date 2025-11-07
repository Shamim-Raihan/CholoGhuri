import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../register/models/otp_verification_response_model.dart';

class RegistrationOtpService {
  static const String _baseUrl = 'https://chologhuri.nbtapp.xyz';
  static const String _apiToken = 'bbFj7NbEHa';
  final Logger _logger = Logger();

 
  Future<OtpVerificationResponse> verifyRegistrationOtp({
    required int tempUserId,
    required String otp,
  }) async {
    try {
      _logger.i('Verifying registration OTP for temp user: $tempUserId');

  
      final uri = Uri.parse(
        '$_baseUrl/api/temp-register-with-otp-verification/$_apiToken',
      ).replace(
        queryParameters: {'temp_user_id': tempUserId.toString(), 'otp': otp},
      );

      _logger.d('OTP verification URL: $uri');

    
      final response = await http.post(uri);

      _logger.d('OTP verification response status: ${response.statusCode}');
      _logger.d('OTP verification response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final verificationResponse = OtpVerificationResponse.fromJson(
          jsonResponse,
        );

        _logger.i(
          'OTP verification successful: ${verificationResponse.message}',
        );
        return verificationResponse;
      } else {
     
        String errorMessage = 'OTP verification failed';
        List<String> errorMessages = [];

        try {
          final jsonResponse = json.decode(response.body);
          _logger.d('Parsed JSON response: $jsonResponse');

          final errorResponse = OtpVerificationResponse.fromJson(jsonResponse);
          errorMessage = errorResponse.message;
          errorMessages = errorResponse.errorMessages;

          _logger.e('OTP verification failed: $errorMessage');
          _logger.d('Error messages: $errorMessages');

          return errorResponse;
        } catch (e) {
          _logger.e('Failed to parse error response: $e');
          _logger.e('Raw response body: ${response.body}');

          return OtpVerificationResponse(
            success: false,
            code: response.statusCode,
            message: errorMessage,
            errorMessages: [response.reasonPhrase ?? 'Unknown error'],
          );
        }
      }
    } catch (e) {
      _logger.e('OTP verification network error: $e');
      return OtpVerificationResponse(
        success: false,
        code: 0,
        message:
            'Network error occurred. Please check your internet connection.',
        errorMessages: [e.toString()],
      );
    }
  }


  Future<bool> resendRegistrationOtp({required int tempUserId}) async {
    try {
      _logger.i('Resending registration OTP for temp user: $tempUserId');

 

      return true;
    } catch (e) {
      _logger.e('Resend OTP error: $e');
      return false;
    }
  }
}
