import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/registration_request_model.dart';
import '../models/registration_response_model.dart';

class RegistrationService {
  static const String _baseUrl = 'https://chologhuri.nbtapp.xyz';
  static const String _apiToken = 'bbFj7NbEHa';
  final Logger _logger = Logger();

  Future<RegistrationResponse> registerTempUser(
    RegistrationRequest request,
  ) async {
    try {
      _logger.i('Sending registration request for: ${request.email}');

      final uri = Uri.parse('$_baseUrl/api/temp-register/$_apiToken');
      final finalUri = uri.replace(queryParameters: request.toQueryParams());

      _logger.d('Registration URL: $finalUri');

      final response = await http.post(finalUri);

      _logger.d('Registration response status: ${response.statusCode}');
      _logger.d('Registration response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final registrationResponse = RegistrationResponse.fromJson(
          jsonResponse,
        );

        _logger.i('Registration successful: ${registrationResponse.message}');
        return registrationResponse;
      } else {
        String errorMessage = 'Registration failed';
        try {
          final jsonResponse = json.decode(response.body);
          _logger.d('Parsed JSON response: $jsonResponse');
          final errorResponse = RegistrationResponse.fromJson(jsonResponse);
          errorMessage = errorResponse.message;
          _logger.e('Registration failed: $errorMessage');
          _logger.d('Field errors: ${errorResponse.fieldErrors}');
          _logger.d(
            'Is mobile number taken: ${errorResponse.isMobileNumberTaken}',
          );
          return errorResponse;
        } catch (e) {
          _logger.e('Failed to parse error response: $e');
          _logger.e('Raw response body: ${response.body}');
          return RegistrationResponse(
            success: false,
            code: response.statusCode,
            message: errorMessage,
            errorMessages: [response.reasonPhrase ?? 'Unknown error'],
            fieldErrors: {},
          );
        }
      }
    } catch (e) {
      _logger.e('Registration network error: $e');
      return RegistrationResponse(
        success: false,
        code: 0,
        message:
            'Network error occurred. Please check your internet connection.',
        errorMessages: [e.toString()],
        fieldErrors: {},
      );
    }
  }

  Future<RegistrationResponse> verifyRegistrationOtp({
    required int tempUserId,
    required String otp,
  }) async {
    try {
      _logger.i('Verifying registration OTP for temp user: $tempUserId');

      final uri = Uri.parse('$_baseUrl/api/verify-registration-otp/$_apiToken');

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'temp_user_id': tempUserId, 'otp': otp}),
      );

      _logger.d('OTP verification response status: ${response.statusCode}');
      _logger.d('OTP verification response body: ${response.body}');

      final jsonResponse = json.decode(response.body);
      final verificationResponse = RegistrationResponse.fromJson(jsonResponse);

      if (response.statusCode == 200 && verificationResponse.success) {
        _logger.i('OTP verification successful');
      } else {
        _logger.e('OTP verification failed: ${verificationResponse.message}');
      }

      return verificationResponse;
    } catch (e) {
      _logger.e('OTP verification error: $e');
      return RegistrationResponse(
        success: false,
        code: 0,
        message: 'Verification failed. Please try again.',
        errorMessages: [e.toString()],
        fieldErrors: {},
      );
    }
  }
}
