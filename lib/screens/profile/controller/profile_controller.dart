import 'package:chologhuri/routes/routes_path.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final RxString userName = 'Asif Rahman'.obs;
  final RxString userPhone = '+880 123 456 789'.obs;
  final RxString userEmail = 'asifrahman@gmail.com'.obs;
  final RxString joinedDate = '12/02/2025'.obs;
  final Rx<File?> profileImage = Rx<File?>(null);

  final RxBool isLoading = false.obs;

  // Getters
  String get userNameValue => userName.value;
  String get userPhoneValue => userPhone.value;
  String get userEmailValue => userEmail.value;
  String get joinedDateValue => joinedDate.value;
  bool get isLoadingValue => isLoading.value;
  File? get profileImageValue => profileImage.value;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    isLoading.value = true;

    try {
      // For now, using static data
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      // Handle error
      debugPrint('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }

  /// Navigate to edit profile screen and wait for result
  void navigateToEditProfile() async {
    try {
      final result = await Get.toNamed(
        RoutesPath.editProfileScreen,
        arguments: {
          'name': userName.value,
          'phone': userPhone.value,
          'email': userEmail.value,
          'imagePath': profileImage.value?.path,
        },
      );

      // Debug print to see what result we get
      debugPrint('Result received: $result');

      // If result is returned from edit screen, update the data
      if (result != null && result is Map<String, dynamic>) {
        debugPrint('Updating user data with: $result');
        updateUserData(
          newName: result['name'],
          newPhone: result['phone'],
          newEmail: result['email'],
          newImagePath: result['imagePath'],
        );

        // Force UI update
        update();

        debugPrint(
          'Updated values - Name: ${userName.value}, Phone: ${userPhone.value}, Email: ${userEmail.value}, Image: ${profileImage.value?.path}',
        );
      } else {
        debugPrint('No result received or invalid result format');
      }
    } catch (e) {
      debugPrint('Error in navigation: $e');
    }
  }

  /// Refresh user data
  void refreshUserData() {
    loadUserData();
  }

  /// Update user data manually (useful for testing)
  void updateUserData({
    String? newName,
    String? newPhone,
    String? newEmail,
    String? newImagePath,
  }) {
    debugPrint(
      'updateUserData called with: name=$newName, phone=$newPhone, email=$newEmail, imagePath=$newImagePath',
    );

    if (newName != null && newName.isNotEmpty) {
      userName.value = newName;
      debugPrint('Updated userName to: ${userName.value}');
    }
    if (newPhone != null && newPhone.isNotEmpty) {
      userPhone.value = newPhone;
      debugPrint('Updated userPhone to: ${userPhone.value}');
    }
    if (newEmail != null && newEmail.isNotEmpty) {
      userEmail.value = newEmail;
      debugPrint('Updated userEmail to: ${userEmail.value}');
    }
    if (newImagePath != null && newImagePath.isNotEmpty) {
      profileImage.value = File(newImagePath);
      debugPrint('Updated profileImage to: ${profileImage.value?.path}');
    }

    // Force rebuild of all GetX widgets
    update();

    // Also trigger reactive updates
    userName.refresh();
    userPhone.refresh();
    userEmail.refresh();
    profileImage.refresh();
  }
}
