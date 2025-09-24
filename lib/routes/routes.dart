import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../screens/launching/view/launching_screen.dart';
import '../screens/login/view/login_screen.dart';
import '../screens/register/view/register_screen.dart';
import '../screens/create_password/view/create_password_screen.dart';
import '../screens/forgot_password/view/forgot_password_screen.dart';
import '../screens/otp_verification/view/otp_verification_screen.dart';
import '../screens/create_new_password/view/create_new_password_screen.dart';
import '../screens/bottom/view/bottom_screen.dart';
import '../screens/services/view/services_screen.dart';
import '../screens/account/view/account_screen.dart';
import '../screens/profile/view/profile_screen.dart';
import '../screens/edit_profile/view/edit_profile_screen.dart';
import '../bindings/common_bindings.dart';
import 'routes_path.dart';

class Routes {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutesPath.initial,
      page: () => LaunchingScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.loginScreen,
      page: () => const LoginScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.registerScreen,
      page: () => const RegisterScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.createPasswordScreen,
      page: () => const CreatePasswordScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.bottomScreen,
      page: () => const BottomScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.otpVerificationScreen,
      page: () => const OtpVerificationScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.createNewPasswordScreen,
      page: () => const CreateNewPasswordScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.servicesScreen,
      page: () => const ServicesScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.accountScreen,
      page: () => const AccountScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.profileScreen,
      page: () => const ProfileScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesPath.editProfileScreen,
      page: () => const EditProfileScreen(),
      binding: CommonBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
