import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../routes/routes_path.dart';
import '../../login/services/auth_services.dart';
import '../../login/services/auth_storage_service.dart';

class OtpVerificationController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final AuthService _authService = AuthService();
  final AuthStorageService _storage = AuthStorageService();
  final Logger _logger = Logger();

  final RxBool _isLoading = false.obs;
  final RxBool _isFormValid = false.obs;
  final RxString _otpCode = ''.obs;
  final RxBool _hasError = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isFormValid => _isFormValid.value;
  String get otpCode => _otpCode.value;
  bool get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();
    otpController.addListener(_validateForm);
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

  void onVerifyPressed() async {
    // hide keyboard if open
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

    _isLoading.value = true;

    try {
      final args = Get.arguments as Map<String, dynamic>?;
      final phone =
          args != null && args['phone'] != null
              ? args['phone'] as String
              : null;
      if (phone == null) {
        throw Exception('Phone number missing');
      }

      final resp = await _authService.login(phone: phone, otp: _otpCode.value);
      _logger.i('Login response: ${resp.message}');

      if (resp.success && resp.data != null) {
        // Save token and user info
        await _storage.saveAuth(
          token: resp.data!.token,
          name: resp.data!.name,
          role: resp.data!.role,
        );

        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(RoutesPath.bottomScreen);
      } else {
        _hasError.value = true;
        Get.snackbar(
          'Error',
          resp.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _hasError.value = true;
      _logger.e('Login failed: $e');
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
    Get.snackbar(
      'Code Sent',
      'New verification code has been sent!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    clearOtp();
  }

  void navigateBack() {
    Get.back();
  }

  @override
  void onClose() {
    // otpController.dispose();
    super.onClose();
  }
}
