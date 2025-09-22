import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class BottomController extends GetxController {
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changeTab(int index) {
    if (index >= 0 && index <= 3) {
      _currentIndex.value = index;
      debugPrint('Navigation changed to index: $index');
    }
  }

  String get currentScreenName {
    switch (_currentIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'Services';
      case 2:
        return 'Activity';
      case 3:
        return 'Account';
      default:
        return 'Unknown';
    }
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('$runtimeType initialized');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('$runtimeType disposed');
  }
}
