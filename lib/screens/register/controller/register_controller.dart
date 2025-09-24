import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes_path.dart';

class RegisterController extends GetxController {
  // User fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Service Provider fields
  final TextEditingController serviceFirstNameController =
      TextEditingController();
  final TextEditingController serviceLastNameController =
      TextEditingController();
  final TextEditingController serviceEmailController = TextEditingController();
  final TextEditingController servicePhoneController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationEmailController =
      TextEditingController();
  final TextEditingController organizationPhoneController =
      TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isTermsAccepted = false.obs;
  final RxBool _isFormValid = false.obs;
  final RxInt _selectedTab = 0.obs;

  bool get isLoading => _isLoading.value;
  bool get isTermsAccepted => _isTermsAccepted.value;
  bool get isFormValid => _isFormValid.value;
  int get selectedTab => _selectedTab.value;

  @override
  void onInit() {
    super.onInit();

    // User fields listeners
    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    phoneController.addListener(_validateForm);

    // Service Provider fields listeners
    serviceFirstNameController.addListener(_validateForm);
    serviceLastNameController.addListener(_validateForm);
    serviceEmailController.addListener(_validateForm);
    servicePhoneController.addListener(_validateForm);
    organizationNameController.addListener(_validateForm);
    organizationEmailController.addListener(_validateForm);
    organizationPhoneController.addListener(_validateForm);
  }

  void selectTab(int index) {
    _selectedTab.value = index;
    _validateForm();
  }

  void toggleTermsAcceptance() {
    _isTermsAccepted.value = !_isTermsAccepted.value;
    _validateForm();
  }

  void _validateForm() {
    bool isValid = false;

    if (_selectedTab.value == 0) {
      // User tab validation
      final isFirstNameValid = firstNameController.text.trim().length >= 2;
      final isLastNameValid = lastNameController.text.trim().length >= 2;
      final isEmailValid = _isValidEmail(emailController.text);
      final isPhoneValid = _isValidPhone(phoneController.text);

      isValid =
          isFirstNameValid &&
          isLastNameValid &&
          isEmailValid &&
          isPhoneValid &&
          _isTermsAccepted.value;
    } else {
      // Service Provider tab validation
      final isFirstNameValid =
          serviceFirstNameController.text.trim().length >= 2;
      final isLastNameValid = serviceLastNameController.text.trim().length >= 2;
      final isEmailValid = _isValidEmail(serviceEmailController.text);
      final isPhoneValid = _isValidPhone(servicePhoneController.text);
      final isOrgNameValid = organizationNameController.text.trim().length >= 2;
      final isOrgEmailValid = _isValidEmail(organizationEmailController.text);
      final isOrgPhoneValid = _isValidPhone(organizationPhoneController.text);

      isValid =
          isFirstNameValid &&
          isLastNameValid &&
          isEmailValid &&
          isPhoneValid &&
          isOrgNameValid &&
          isOrgEmailValid &&
          isOrgPhoneValid &&
          _isTermsAccepted.value;
    }

    _isFormValid.value = isValid;
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    if (phone.isEmpty) return false;
    final phoneRegex = RegExp(r'^\d{10,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
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
    // User controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    // Service Provider controllers
    serviceFirstNameController.dispose();
    serviceLastNameController.dispose();
    serviceEmailController.dispose();
    servicePhoneController.dispose();
    organizationNameController.dispose();
    organizationEmailController.dispose();
    organizationPhoneController.dispose();

    super.onClose();
  }
}
