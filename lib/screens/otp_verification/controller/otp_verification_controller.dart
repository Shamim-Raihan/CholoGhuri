import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';

class OtpVerificationController extends GetxController {
  final TextEditingController otpController = TextEditingController();

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
    _isFormValid.value = otpController.text.length == 5;
    _hasError.value = false;
  }

  void onOtpCompleted(String value) {
    _otpCode.value = value;
    _isFormValid.value = value.length == 5;
    _hasError.value = false;
  }

  void onOtpChanged(String value) {
    _otpCode.value = value;
    _isFormValid.value = value.length == 5;
    _hasError.value = false;
  }

  void clearOtp() {
    otpController.clear();
    _otpCode.value = '';
    _isFormValid.value = false;
    _hasError.value = false;
  }

  void onVerifyPressed() async {
    if (!_isFormValid.value) {
      _hasError.value = true;
      Get.snackbar(
        'Invalid OTP',
        'Please enter the complete 5-digit verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (_otpCode.value.length == 5) {
        Get.snackbar(
          'Success',
          'OTP verified successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(RoutesPath.bottomScreen);
      } else {
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      _hasError.value = true;
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
    otpController.dispose();
    super.onClose();
  }
}
