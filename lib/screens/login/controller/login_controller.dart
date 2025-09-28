import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isPasswordVisible = false.obs;
  final RxBool _isFormValid = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isPasswordVisible => _isPasswordVisible.value;
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

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(email)) return true;

    final mobileRegex = RegExp(r'^\d{10,15}$');
    return mobileRegex.hasMatch(email.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  void onLoginPressed() async {
    if (!_isFormValid.value) {
      Get.snackbar(
        'Invalid Input',
        'Please enter valid email/mobile and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Otp sent successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(RoutesPath.otpVerificationScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
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

  void navigateToForgotPassword() {
    Get.toNamed('/forgot_password_screen');
  }

  @override
  void onClose() {
    emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
