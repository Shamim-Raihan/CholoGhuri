import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../routes/routes_path.dart';
import '../services/auth_services.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final AuthService _authService = AuthService();
  final Logger _logger = Logger();

  final RxBool _isLoading = false.obs;
  final RxBool _isFormValid = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid = _isValidPhone(phoneController.text);
    _isFormValid.value = isValid;
  }

  bool _isValidPhone(String value) {
    if (value.isEmpty) return false;
    final normalized = value.replaceAll(RegExp(r'[^0-9]'), '');
    return normalized.length == 11;
  }

  void onLoginPressed() async {
    // hide the keyboard if open
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_isFormValid.value) {
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid 11-digit phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;
    final phone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      final resp = await _authService.sendOtp(phone: phone);
      _logger.i('OTP send response: ${resp.message}');

      if (resp.success) {
        Get.snackbar(
          'Success',
          'Otp sent successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(
          RoutesPath.otpVerificationScreen,
          arguments: {'phone': phone},
        );
      } else {
        Get.snackbar(
          'Error',
          resp.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _logger.e('Failed to send OTP: $e');
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.toNamed('/register_screen');
  }

  @override
  void onClose() {
    // phoneController.dispose();
    super.onClose();
  }
}
