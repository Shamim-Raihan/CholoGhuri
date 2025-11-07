import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../../../routes/routes_path.dart';
import '../models/registration_request_model.dart';
import '../services/registration_service.dart';

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
    _validateAndShowErrors();

    if (!_isFormValid.value) {
      return;
    }

    if (_selectedTab.value == 0) {
      debugPrint('2');
    } else {
      debugPrint('3');
    }

    _printAllFormInfo();

    _isLoading.value = true;

    try {
      final RegistrationRequest request = _createRegistrationRequest();

      debugPrint('📤 Sending registration request...');
      final response = await _registrationService.registerTempUser(request);

      if (response.success && response.data != null) {
        debugPrint(
          '✅ Registration successful! Temp User ID: ${response.data!.tempUserId}',
        );

        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(
          RoutesPath.registrationOtpScreen,
          arguments: {
            'temp_user_id': response.data!.tempUserId,
            'mobile_no': response.data!.tempUserMobileNo,
            'otp_expired': response.data!.otpExpired,
            'otp_expired_at': response.data!.otpExpiredAt,
          },
        );
      } else {
        debugPrint('❌ Registration failed: ${response.message}');

        if (response.isMobileNumberTaken) {
          _phoneError.value =
              response.mobileNumberError ??
              'This mobile number is already registered';
        } else {
          Get.snackbar(
            'Registration Failed',
            response.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      debugPrint('💥 Registration error: $e');

      if (e.toString().toLowerCase().contains('mobile') &&
          e.toString().toLowerCase().contains('taken')) {
        _phoneError.value = 'This mobile number is already registered';
      } else {
        Get.snackbar(
          'Error',
          'Registration failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      _isLoading.value = false;
    }
  }

  RegistrationRequest _createRegistrationRequest() {
    if (_selectedTab.value == 0) {
      return RegistrationRequest(
        name:
            '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        email: emailController.text.trim(),
        mobileNo: phoneController.text.trim(),
        latitude: latitudeController.text.trim(),
        longitude: longitudeController.text.trim(),
        macAddress: macAddressController.text.trim(),
        ipAddress: ipAddressController.text.trim(),
        deviceType: '1',
        basicUserType: '2',
        country: countryController.text.trim(),
        division: divisionController.text.trim(),
        district: districtController.text.trim(),
        thanaUpazila: thanaUpazilaController.text.trim(),
        address: addressController.text.trim(),
      );
    } else {
      return RegistrationRequest(
        name:
            '${serviceFirstNameController.text.trim()} ${serviceLastNameController.text.trim()}',
        email: serviceEmailController.text.trim(),
        mobileNo: servicePhoneController.text.trim(),
        latitude: serviceLatitudeController.text.trim(),
        longitude: serviceLongitudeController.text.trim(),
        macAddress: serviceMacAddressController.text.trim(),
        ipAddress: serviceIpAddressController.text.trim(),
        deviceType: '1',
        basicUserType: '3',
        country: serviceCountryController.text.trim(),
        division: serviceDivisionController.text.trim(),
        district: serviceDistrictController.text.trim(),
        thanaUpazila: serviceThanaUpazilaController.text.trim(),
        address: serviceAddressController.text.trim(),
      );
    }
  }

  void _printAllFormInfo() {
    debugPrint('==========================================');
    debugPrint('📋 REGISTRATION FORM INFORMATION');
    debugPrint('==========================================');

    if (_selectedTab.value == 0) {
      debugPrint('👤 USER REGISTRATION DATA:');
      debugPrint('First Name: ${firstNameController.text}');
      debugPrint('Last Name: ${lastNameController.text}');
      debugPrint('Email: ${emailController.text}');
      debugPrint('Phone: ${phoneController.text}');
      debugPrint('Latitude: ${latitudeController.text}');
      debugPrint('Longitude: ${longitudeController.text}');
      debugPrint('MAC Address: ${macAddressController.text}');
      debugPrint('IP Address: ${ipAddressController.text}');
      debugPrint('Country: ${countryController.text}');
      debugPrint('Division: ${divisionController.text}');
      debugPrint('District: ${districtController.text}');
      debugPrint('Thana/Upazila: ${thanaUpazilaController.text}');
      debugPrint('Address: ${addressController.text}');
    } else {
      debugPrint('🏢 SERVICE PROVIDER REGISTRATION DATA:');
      debugPrint('First Name: ${serviceFirstNameController.text}');
      debugPrint('Last Name: ${serviceLastNameController.text}');
      debugPrint('Email: ${serviceEmailController.text}');
      debugPrint('Phone: ${servicePhoneController.text}');
      debugPrint('Latitude: ${serviceLatitudeController.text}');
      debugPrint('Longitude: ${serviceLongitudeController.text}');
      debugPrint('MAC Address: ${serviceMacAddressController.text}');
      debugPrint('IP Address: ${serviceIpAddressController.text}');
      debugPrint('Country: ${serviceCountryController.text}');
      debugPrint('Division: ${serviceDivisionController.text}');
      debugPrint('District: ${serviceDistrictController.text}');
      debugPrint('Thana/Upazila: ${serviceThanaUpazilaController.text}');
      debugPrint('Address: ${serviceAddressController.text}');
    }

    debugPrint('Terms Accepted: ${_isTermsAccepted.value}');
    debugPrint('==========================================');
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
