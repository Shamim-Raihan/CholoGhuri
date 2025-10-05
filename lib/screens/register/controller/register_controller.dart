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
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();
  var macAddressController = TextEditingController();
  var ipAddressController = TextEditingController();
  var countryController = TextEditingController();
  var divisionController = TextEditingController();
  var districtController = TextEditingController();
  var thanaUpazilaController = TextEditingController();
  var addressController = TextEditingController();
  var serviceFirstNameController = TextEditingController();
  var serviceLastNameController = TextEditingController();
  var serviceEmailController = TextEditingController();
  var servicePhoneController = TextEditingController();
  var serviceLatitudeController = TextEditingController();
  var serviceLongitudeController = TextEditingController();
  var serviceMacAddressController = TextEditingController();
  var serviceIpAddressController = TextEditingController();
  var serviceCountryController = TextEditingController();
  var serviceDivisionController = TextEditingController();
  var serviceDistrictController = TextEditingController();
  var serviceThanaUpazilaController = TextEditingController();
  var serviceAddressController = TextEditingController();

  // Registration service
  final RegistrationService _registrationService = RegistrationService();

  final RxBool _isLoading = false.obs;
  final RxBool _isTermsAccepted = false.obs;
  final RxBool _isFormValid = false.obs;
  final RxInt _selectedTab = 0.obs;
  final RxBool _isFetchingLocation = false.obs;

  // Error tracking for individual fields
  final RxString _firstNameError = ''.obs;
  final RxString _lastNameError = ''.obs;
  final RxString _emailError = ''.obs;
  final RxString _phoneError = ''.obs;
  final RxString _macAddressError = ''.obs;
  final RxString _ipAddressError = ''.obs;
  final RxString _termsError = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isTermsAccepted => _isTermsAccepted.value;
  bool get isFormValid => _isFormValid.value;
  int get selectedTab => _selectedTab.value;
  bool get isFetchingLocation => _isFetchingLocation.value;

  // Error getters
  String get firstNameError => _firstNameError.value;
  String get lastNameError => _lastNameError.value;
  String get emailError => _emailError.value;
  String get phoneError => _phoneError.value;
  String get macAddressError => _macAddressError.value;
  String get ipAddressError => _ipAddressError.value;
  String get termsError => _termsError.value;

  @override
  void onInit() {
    super.onInit();

    // User fields listeners - only for visible/editable fields
    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    phoneController.addListener(_validateForm);

    // Service Provider fields listeners - only for visible/editable fields
    serviceFirstNameController.addListener(_validateForm);
    serviceLastNameController.addListener(_validateForm);
    serviceEmailController.addListener(_validateForm);
    servicePhoneController.addListener(_validateForm);

    // Automatically fetch location when user arrives at registration screen
    _autoFetchLocationOnInit();
  }

  void _autoFetchLocationOnInit() async {
    // Add a small delay to let the UI settle
    await Future.delayed(const Duration(milliseconds: 500));

    // Fetch location and device info simultaneously
    await Future.wait([fillCurrentLocation(), _fillDeviceInfo()]);
  }

  void selectTab(int index) {
    _selectedTab.value = index;
    _validateForm();
  }

  /// Request current device location, fill latitude/longitude and reverse-geocode
  /// to automatically populate country/division/district/thana/address fields.
  Future<void> fillCurrentLocation() async {
    debugPrint('🌍 Starting location fetch...');
    _isFetchingLocation.value = true;
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        Get.snackbar(
          'Permission denied',
          'Location permission is required to auto-fill address',
        );
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      debugPrint('=== LOCATION DATA ===');
      debugPrint('Latitude: ${pos.latitude}');
      debugPrint('Longitude: ${pos.longitude}');
      debugPrint('Accuracy: ${pos.accuracy}m');
      debugPrint('Altitude: ${pos.altitude}m');

      if (_selectedTab.value == 0) {
        latitudeController.text = pos.latitude.toString();
        longitudeController.text = pos.longitude.toString();
      } else {
        serviceLatitudeController.text = pos.latitude.toString();
        serviceLongitudeController.text = pos.longitude.toString();
      }

      // Reverse geocode
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final composedAddress = [
          p.street,
          p.subLocality,
          p.locality,
          p.postalCode,
          p.country,
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        debugPrint('=== REVERSE GEOCODING DATA ===');
        debugPrint('Country: ${p.country}');
        debugPrint('Administrative Area (Division): ${p.administrativeArea}');
        debugPrint(
          'Sub Administrative Area (Thana): ${p.subAdministrativeArea}',
        );
        debugPrint('Locality (District): ${p.locality}');
        debugPrint('Sub Locality: ${p.subLocality}');
        debugPrint('Street: ${p.street}');
        debugPrint('Postal Code: ${p.postalCode}');
        debugPrint('Composed Address: $composedAddress');
        debugPrint('=======================');

        if (_selectedTab.value == 0) {
          countryController.text = p.country ?? '';
          divisionController.text = p.administrativeArea ?? '';
          districtController.text = p.locality ?? '';
          thanaUpazilaController.text = p.subAdministrativeArea ?? '';
          addressController.text = composedAddress;
        } else {
          serviceCountryController.text = p.country ?? '';
          serviceDivisionController.text = p.administrativeArea ?? '';
          serviceDistrictController.text = p.locality ?? '';
          serviceThanaUpazilaController.text = p.subAdministrativeArea ?? '';
          serviceAddressController.text = composedAddress;
        }
      }
    } catch (e) {
      debugPrint('❌ Location error: $e');
      Get.snackbar('Location error', e.toString());
    } finally {
      debugPrint('✅ Location fetch completed');
      _isFetchingLocation.value = false;
      _validateForm();
    }
  }

  Future<void> _fillDeviceInfo() async {
    debugPrint('📱 Starting device info fetch...');
    try {
      final deviceInfo = DeviceInfoPlugin();
      String deviceId = '';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        debugPrint('=== ANDROID DEVICE INFO ===');
        debugPrint('Android ID: ${androidInfo.id}');
        debugPrint('Brand: ${androidInfo.brand}');
        debugPrint('Model: ${androidInfo.model}');
        debugPrint('Device: ${androidInfo.device}');
        debugPrint('==========================');
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown';
        debugPrint('=== IOS DEVICE INFO ===');
        debugPrint('Identifier for Vendor: ${iosInfo.identifierForVendor}');
        debugPrint('Name: ${iosInfo.name}');
        debugPrint('Model: ${iosInfo.model}');
        debugPrint('System Name: ${iosInfo.systemName}');
        debugPrint('=======================');
      }

      // Set the same device ID for both MAC and IP address fields
      if (_selectedTab.value == 0) {
        macAddressController.text = deviceId;
        ipAddressController.text = deviceId;
      } else {
        serviceMacAddressController.text = deviceId;
        serviceIpAddressController.text = deviceId;
      }

      debugPrint('✅ Device info fetch completed - ID: $deviceId');
    } catch (e) {
      debugPrint('❌ Device info error: $e');

      // Fallback to a generated ID if device info fails
      final fallbackId = DateTime.now().millisecondsSinceEpoch.toString();
      if (_selectedTab.value == 0) {
        macAddressController.text = fallbackId;
        ipAddressController.text = fallbackId;
      } else {
        serviceMacAddressController.text = fallbackId;
        serviceIpAddressController.text = fallbackId;
      }
      debugPrint('🔄 Using fallback ID: $fallbackId');
    }
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
      final isLatitudeValid = latitudeController.text.trim().isNotEmpty;
      final isLongitudeValid = longitudeController.text.trim().isNotEmpty;
      final isMacValid = macAddressController.text.trim().isNotEmpty;
      final isIpValid = ipAddressController.text.trim().isNotEmpty;
      final isCountryValid = countryController.text.trim().isNotEmpty;
      final isDivisionValid = divisionController.text.trim().isNotEmpty;
      final isDistrictValid = districtController.text.trim().isNotEmpty;
      final isThanaValid = thanaUpazilaController.text.trim().isNotEmpty;
      final isAddressValid = addressController.text.trim().isNotEmpty;

      isValid =
          isFirstNameValid &&
          isLastNameValid &&
          isEmailValid &&
          isPhoneValid &&
          isLatitudeValid &&
          isLongitudeValid &&
          isMacValid &&
          isIpValid &&
          isCountryValid &&
          isDivisionValid &&
          isDistrictValid &&
          isThanaValid &&
          isAddressValid &&
          _isTermsAccepted.value;
    } else {
      // Service Provider tab validation
      final isFirstNameValid =
          serviceFirstNameController.text.trim().length >= 2;
      final isLastNameValid = serviceLastNameController.text.trim().length >= 2;
      final isEmailValid = _isValidEmail(serviceEmailController.text);
      final isPhoneValid = _isValidPhone(servicePhoneController.text);

      final isLatitudeValid = serviceLatitudeController.text.trim().isNotEmpty;
      final isLongitudeValid =
          serviceLongitudeController.text.trim().isNotEmpty;
      final isMacValid = serviceMacAddressController.text.trim().isNotEmpty;
      final isIpValid = serviceIpAddressController.text.trim().isNotEmpty;
      final isCountryValid = serviceCountryController.text.trim().isNotEmpty;
      final isDivisionValid = serviceDivisionController.text.trim().isNotEmpty;
      final isDistrictValid = serviceDistrictController.text.trim().isNotEmpty;
      final isThanaValid = serviceThanaUpazilaController.text.trim().isNotEmpty;
      final isAddressValid = serviceAddressController.text.trim().isNotEmpty;

      isValid =
          isFirstNameValid &&
          isLastNameValid &&
          isEmailValid &&
          isPhoneValid &&
          isLatitudeValid &&
          isLongitudeValid &&
          isMacValid &&
          isIpValid &&
          isCountryValid &&
          isDivisionValid &&
          isDistrictValid &&
          isThanaValid &&
          isAddressValid &&
          _isTermsAccepted.value;
    }

    _isFormValid.value = isValid;
  }

  void _validateAndShowErrors() {
    // Clear previous errors
    _firstNameError.value = '';
    _lastNameError.value = '';
    _emailError.value = '';
    _phoneError.value = '';
    _macAddressError.value = '';
    _ipAddressError.value = '';
    _termsError.value = '';

    if (_selectedTab.value == 0) {
      // User tab validation with error messages
      if (firstNameController.text.trim().length < 2) {
        _firstNameError.value = 'First name is required (min 2 characters)';
      }
      if (lastNameController.text.trim().length < 2) {
        _lastNameError.value = 'Last name is required (min 2 characters)';
      }
      if (!_isValidEmail(emailController.text)) {
        _emailError.value = 'Valid email is required';
      }
      if (!_isValidPhone(phoneController.text)) {
        _phoneError.value = 'Valid phone number is required';
      }
      if (macAddressController.text.trim().isEmpty) {
        _macAddressError.value = 'MAC address is required';
      }
      if (ipAddressController.text.trim().isEmpty) {
        _ipAddressError.value = 'IP address is required';
      }
    } else {
      // Service Provider tab validation with error messages
      if (serviceFirstNameController.text.trim().length < 2) {
        _firstNameError.value = 'First name is required (min 2 characters)';
      }
      if (serviceLastNameController.text.trim().length < 2) {
        _lastNameError.value = 'Last name is required (min 2 characters)';
      }
      if (!_isValidEmail(serviceEmailController.text)) {
        _emailError.value = 'Valid email is required';
      }
      if (!_isValidPhone(servicePhoneController.text)) {
        _phoneError.value = 'Valid phone number is required';
      }
      if (serviceMacAddressController.text.trim().isEmpty) {
        _macAddressError.value = 'MAC address is required';
      }
      if (serviceIpAddressController.text.trim().isEmpty) {
        _ipAddressError.value = 'IP address is required';
      }
    }

    if (!_isTermsAccepted.value) {
      _termsError.value = 'Please accept terms and conditions';
    }

    _validateForm();
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    latitudeController.dispose();
    longitudeController.dispose();
    macAddressController.dispose();
    ipAddressController.dispose();
    countryController.dispose();
    divisionController.dispose();
    districtController.dispose();
    thanaUpazilaController.dispose();
    addressController.dispose();

    serviceFirstNameController.dispose();
    serviceLastNameController.dispose();
    serviceEmailController.dispose();
    servicePhoneController.dispose();
    serviceLatitudeController.dispose();
    serviceLongitudeController.dispose();
    serviceMacAddressController.dispose();
    serviceIpAddressController.dispose();
    serviceCountryController.dispose();
    serviceDivisionController.dispose();
    serviceDistrictController.dispose();
    serviceThanaUpazilaController.dispose();
    serviceAddressController.dispose();

    super.onClose();
  }
}
