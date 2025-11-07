import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../routes/routes_path.dart';
import '../services/auth_services.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isFormValid = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateForm);
    // passwordController.addListener(_validateForm);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void _validateForm() {
    final isEmailValid = _isValidEmail(emailController.text);
    // final isPasswordValid = passwordController.text.length >= 6;
    _isFormValid.value = isEmailValid;
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
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(RoutesPath.otpVerificationScreen);
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
    emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
