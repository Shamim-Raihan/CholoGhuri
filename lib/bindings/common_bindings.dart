import 'package:get/get.dart';
import '../../screens/registration_otp/controller/registration_otp_controller.dart';

class CommonBindings extends Bindings {
  @override
  void dependencies() {
    // Registration OTP Controller
    Get.lazyPut<RegistrationOtpController>(() => RegistrationOtpController());

    // Add other controllers here as needed
    // Get.lazyPut<LaunchingController>(() => LaunchingController());
  }
}
