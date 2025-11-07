import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/otp_models.dart';
import '../models/user_models.dart';

class AuthService {
  final Logger _logger = Logger();

  Future<OtpResponse> sendOtp({required String phone}) async {
    final uri = Uri.parse(
      'https://chologhuri.nbtapp.xyz/api/send-login-otp/bbFj7NbEHa?user_id=$phone',
    );
    _logger.i('Sending OTP request to $uri');

    final request = http.Request('POST', uri);

    final streamed = await request.send();
    final body = await streamed.stream.bytesToString();
    _logger.d('OTP response status: ${streamed.statusCode} body: $body');

    if (streamed.statusCode == 200) {
      final map = json.decode(body) as Map<String, dynamic>;
      return OtpResponse.fromMap(map);
    }

    throw Exception('Failed to send OTP: ${streamed.reasonPhrase}');
  }

  Future<LoginResponse> login({
    required String phone,
    required String otp,
  }) async {
    final uri = Uri.parse(
      'https://chologhuri.nbtapp.xyz/api/login/bbFj7NbEHa?user_id=$phone&password=$otp',
    );
    _logger.i('Login request to $uri');

    final request = http.Request('POST', uri);

    final streamed = await request.send();
    final body = await streamed.stream.bytesToString();
    _logger.d('Login response status: ${streamed.statusCode} body: $body');

    if (streamed.statusCode == 200) {
      final map = json.decode(body) as Map<String, dynamic>;
      return LoginResponse.fromMap(map);
    }

    throw Exception('Failed to login: ${streamed.reasonPhrase}');
  }
}
