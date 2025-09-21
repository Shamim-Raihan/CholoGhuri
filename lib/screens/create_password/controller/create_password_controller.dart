import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isPasswordVisible = false.obs;
  final RxBool _isConfirmPasswordVisible = false.obs;
  final RxBool _isFormValid = false.obs;
  final RxString _password = ''.obs;
  final RxString _confirmPassword = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  bool get isFormValid => _isFormValid.value;
  String get password => _password.value;
  String get confirmPassword => _confirmPassword.value;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_onPasswordChanged);
    confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  void _onPasswordChanged() {
    _password.value = passwordController.text;
    _validateForm();
  }

  void _onConfirmPasswordChanged() {
    _confirmPassword.value = confirmPasswordController.text;
    _validateForm();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  void _validateForm() {
    final password = _password.value;
    final confirmPassword = _confirmPassword.value;

    final isPasswordValid = _isValidPassword(password);
    final isConfirmPasswordValid =
        confirmPassword.isNotEmpty && password == confirmPassword;

    _isFormValid.value = isPasswordValid && isConfirmPasswordValid;
  }

  bool _isValidPassword(String password) {
    if (password.length < 8) return false;
    return password.length >= 8;
  }

  String getPasswordStrengthText() {
    final password = _password.value;
    if (password.isEmpty) return '';

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChars = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int strength = 0;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasDigits) strength++;
    if (hasSpecialChars) strength++;

    switch (strength) {
      case 0:
      case 1:
        return 'Weak password';
      case 2:
        return 'Fair password';
      case 3:
        return 'Good password';
      case 4:
        return 'Strong password';
      default:
        return '';
    }
  }

  String? getPasswordMatchError() {
    final password = _password.value;
    final confirmPassword = _confirmPassword.value;

    if (confirmPassword.isNotEmpty && password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  void onNextPressed() async {
    if (!_isFormValid.value) {
      Get.snackbar(
        'Invalid Input',
        'Please ensure both passwords are valid and match',
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
        'Account created successfully! Please login to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed('/login_screen');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Account creation failed. Please try again.',
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
