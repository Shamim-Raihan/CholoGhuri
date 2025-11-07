import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../routes/routes_path.dart';
import '../services/registration_otp_service.dart';

class RegistrationOtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();

  final RegistrationOtpService _otpService = RegistrationOtpService();
  final Logger _logger = Logger();

  final RxBool _isLoading = false.obs;
  final RxBool _isFormValid = false.obs;
  final RxString _otpCode = ''.obs;
  final RxBool _hasError = false.obs;
  final RxInt _countdown = 90.obs;
  final RxBool _canResend = false.obs;

  Timer? _countdownTimer;
  int? tempUserId;
  String? mobileNo;
  String? otpExpired;
  String? otpExpiredAt;

  bool get isLoading => _isLoading.value;
  bool get isFormValid => _isFormValid.value;
  String get otpCode => _otpCode.value;
  bool get hasError => _hasError.value;
  int get countdown => _countdown.value;
  bool get canResend => _canResend.value;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      tempUserId = args['temp_user_id'] as int?;
      mobileNo = args['mobile_no'] as String?;
      otpExpired = args['otp_expired'] as String?;
      otpExpiredAt = args['otp_expired_at'] as String?;

      if (otpExpired != null) {
        _countdown.value = int.tryParse(otpExpired!) ?? 90;
      }

      _logger.i(
        'Registration OTP initialized for temp user: $tempUserId, mobile: $mobileNo',
      );
    }

    otpController.addListener(_validateForm);
    _startCountdown();
  }

  void _validateForm() {
    _otpCode.value = otpController.text;
    _isFormValid.value = otpController.text.length == 6;
    _hasError.value = false;
  }

  void onOtpCompleted(String value) {
    _otpCode.value = value;
    _isFormValid.value = value.length == 6;
    _hasError.value = false;
  }

  void onOtpChanged(String value) {
    _otpCode.value = value;
    _isFormValid.value = value.length == 6;
    _hasError.value = false;
  }

  void clearOtp() {
    otpController.clear();
    _otpCode.value = '';
    _isFormValid.value = false;
    _hasError.value = false;
  }

  void _startCountdown() {
    _canResend.value = false;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown.value > 0) {
        _countdown.value--;
      } else {
        _canResend.value = true;
        timer.cancel();
      }
    });
  }

  String get formattedCountdown {
    final minutes = (_countdown.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (_countdown.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void onVerifyPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_isFormValid.value) {
      _hasError.value = true;
      Get.snackbar(
        'Invalid OTP',
        'Please enter the complete 6-digit verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (tempUserId == null) {
      _hasError.value = true;
      Get.snackbar(
        'Error',
        'Registration session expired. Please register again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      _logger.i('Verifying registration OTP: ${_otpCode.value}');

      final response = await _otpService.verifyRegistrationOtp(
        tempUserId: tempUserId!,
        otp: _otpCode.value,
      );

      if (response.success) {
        _logger.i('Registration OTP verification successful');

        if (response.data?.token != null) {
          _logger.i('User authenticated: ${response.data!.name}');
          // TODO: Store token in secure storage for future API calls
        }

        Get.snackbar(
          'Success',
          'Registration completed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(RoutesPath.bottomScreen);
      } else {
        _hasError.value = true;
        _logger.e('Registration OTP verification failed: ${response.message}');

        Get.snackbar(
          'Verification Failed',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _hasError.value = true;
      _logger.e('Registration OTP verification error: $e');

      Get.snackbar(
        'Error',
        'Invalid verification code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void onResendPressed() async {
    if (!_canResend.value || tempUserId == null) return;

    _logger.i('Resending registration OTP for temp user: $tempUserId');

    try {
      final success = await _otpService.resendRegistrationOtp(
        tempUserId: tempUserId!,
      );

      if (success) {
        _countdown.value = 90;
        _startCountdown();

        Get.snackbar(
          'Code Sent',
          'New verification code has been sent!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        clearOtp();
      } else {
        Get.snackbar(
          'Error',
          'Failed to resend code. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _logger.e('Resend OTP error: $e');
      Get.snackbar(
        'Error',
        'Failed to resend code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void navigateBack() {
    Get.back();
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
