import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileController extends GetxController {
  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Image picker
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  // Getters
  bool get isLoadingValue => isLoading.value;
  bool get isSavingValue => isSaving.value;
  File? get selectedImageValue => selectedImage.value;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  /// Load current user data into form fields
  void loadUserData() {
    isLoading.value = true;

    try {
      // Get data from arguments passed from ProfileScreen
      final Map<String, dynamic>? args = Get.arguments;

      if (args != null) {
        nameController.text = args['name'] ?? 'Asif Rahman';
        phoneController.text = args['phone'] ?? '+880 123 456 789';
        emailController.text = args['email'] ?? 'asifrahman@gmail.com';

        // Load existing image if available
        if (args['imagePath'] != null &&
            args['imagePath'].toString().isNotEmpty) {
          selectedImage.value = File(args['imagePath']);
        }
      } else {
        // Default values if no arguments passed
        nameController.text = 'Asif Rahman';
        phoneController.text = '+880 123 456 789';
        emailController.text = 'asifrahman@gmail.com';
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate back to profile screen without saving
  void goBack() {
    Get.back();
  }

  /// Show image picker options
  void showImagePicker() {
    Get.bottomSheet(
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              'Select Profile Picture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _buildImageOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
                if (selectedImage.value != null)
                  _buildImageOption(
                    icon: Icons.delete,
                    label: 'Remove',
                    onTap: _removeImage,
                    color: Colors.red,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build image picker option widget
  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      Get.back(); // Close bottom sheet

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        debugPrint('Image selected: ${pickedFile.path}');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Remove selected image
  void _removeImage() {
    Get.back(); // Close bottom sheet
    selectedImage.value = null;
  }

  /// Validate form fields
  bool _validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  /// Save profile changes and return to previous screen
  void saveProfile() async {
    if (!_validateForm()) {
      return;
    }

    isSaving.value = true;

    try {
      //
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      final updatedData = {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'imagePath': selectedImage.value?.path,
      };

      // Go back to profile screen with updated data FIRST
      Get.back(result: updatedData);

      // Show success message after navigation
      await Future.delayed(const Duration(milliseconds: 100));
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isSaving.value = false;
    }
  }

  /// Validate name field
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validate phone field
  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    // Basic phone validation - you can make this more sophisticated
    if (value.trim().length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validate email field
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
