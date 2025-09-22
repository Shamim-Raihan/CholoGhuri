import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';

class CreateNewPasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isFormValid = false.obs;
  final RxBool _isPasswordVisible = false.obs;
  final RxBool _isConfirmPasswordVisible = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isFormValid => _isFormValid.value;
  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final isPasswordValid = _isValidPassword(passwordController.text);
    final isConfirmPasswordValid = confirmPasswordController.text.isNotEmpty;
    final isPasswordsMatch =
        passwordController.text == confirmPasswordController.text;

    _isFormValid.value =
        isPasswordValid && isConfirmPasswordValid && isPasswordsMatch;
  }

  bool _isValidPassword(String password) {
    if (password.length < 8) return false;
    return true;
  }

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  void onNextPressed() async {
    if (!_isFormValid.value) {
      if (passwordController.text.length < 8) {
        Get.snackbar(
          'Invalid Password',
          'Password must be at least 6 characters long',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Password Mismatch',
          'Passwords do not match. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      Get.snackbar(
        'Invalid Input',
        'Please fill in all required fields',
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
        'Password reset successful! Please login with your new password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(RoutesPath.loginScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reset password. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void navigateBack() {
    Get.back();
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
