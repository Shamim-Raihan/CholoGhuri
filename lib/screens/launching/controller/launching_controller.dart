import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../../routes/routes_path.dart';

class LaunchingController extends GetxController {
  // Reactive variables
  final RxBool _isLoading = false.obs;

  // Getters
  bool get isLoading => _isLoading.value;

  // Navigation methods
  void navigateToNextScreen() {
    // Navigate to login screen
    Get.offAllNamed(RoutesPath.loginScreen);
  }

  // Auto navigation after delay
  void _autoNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    navigateToNextScreen();
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('$runtimeType initialized');
    _autoNavigate(); // Auto navigate after 3 seconds
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('$runtimeType disposed');
  }
}
