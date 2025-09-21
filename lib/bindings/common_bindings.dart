import 'package:get/get.dart';
import '../screens/launching/controller/launching_controller.dart';
import '../screens/login/controller/login_controller.dart';
import '../screens/register/controller/register_controller.dart';
import '../screens/create_password/controller/create_password_controller.dart';

class CommonBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaunchingController>(() => LaunchingController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<CreatePasswordController>(() => CreatePasswordController());

    // Add other controllers here as you create new screens
    // Example:
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
