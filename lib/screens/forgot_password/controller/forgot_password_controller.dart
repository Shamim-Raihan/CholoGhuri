import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isFormValid = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateForm);
  }

  void _validateForm() {
    final isEmailValid = _isValidEmail(emailController.text);
    _isFormValid.value = isEmailValid;
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;

    // Check if it's a valid email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(email)) return true;

    // Check if it's a valid mobile number (10-15 digits)
    final mobileRegex = RegExp(r'^\d{10,15}$');
    return mobileRegex.hasMatch(email.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  void onSendCodePressed() async {
    if (!_isFormValid.value) {
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid email or mobile number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Code Sent',
        'Password reset code has been sent successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to OTP verification screen
      Get.toNamed(RoutesPath.otpVerificationScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void navigateToLogin() {
    Get.offNamed(RoutesPath.loginScreen);
  }

  void navigateBack() {
    Get.back();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
