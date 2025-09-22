import 'package:get/get.dart';
import '../../../components/dialogs.dart';
import '../../../routes/routes_path.dart';

class AccountController extends GetxController {
  // Reactive variables
  final RxBool isLoading = false.obs;

  // Getters for reactive variables
  bool get isLoadingValue => isLoading.value;

  // Navigation methods for menu items
  void navigateToFAQ() {
    Get.snackbar(
      'Info',
      'FAQ screen will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToPaymentHistory() {
    Get.snackbar(
      'Info',
      'Payment History screen will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToSettings() {
    //
    Get.snackbar(
      'Info',
      'Settings screen will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToProfile() {
    Get.toNamed(RoutesPath.profileScreen);
  }

  // Logout functionality
  void onLogoutPressed() {
    Dialogs.showLogoutConfirmationDialog(onConfirm: _performLogout);
  }

  void _performLogout() async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1));

      Get.offAllNamed(RoutesPath.loginScreen);

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}
