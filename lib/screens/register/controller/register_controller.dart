import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';

class RegisterController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isTermsAccepted = false.obs;
  final RxBool _isFormValid = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isTermsAccepted => _isTermsAccepted.value;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();

    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
  }

  void toggleTermsAcceptance() {
    _isTermsAccepted.value = !_isTermsAccepted.value;
    _validateForm();
  }

  void _validateForm() {
    final isFirstNameValid = firstNameController.text.trim().length >= 2;
    final isLastNameValid = lastNameController.text.trim().length >= 2;
    final isEmailValid = _isValidEmail(emailController.text);

    _isFormValid.value =
        isFirstNameValid &&
        isLastNameValid &&
        isEmailValid &&
        _isTermsAccepted.value;
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(email)) return true;

    final mobileRegex = RegExp(r'^\d{10,15}$');
    return mobileRegex.hasMatch(email.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  void openTermsAndConditions() {
    Get.snackbar(
      'Info',
      'Terms and Conditions page not yet implemented',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onNextPressed() async {
    if (!_isFormValid.value) {
      Get.snackbar(
        'Invalid Input',
        'Please fill all fields and accept terms and conditions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      Get.toNamed(RoutesPath.createPasswordScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void navigateToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
