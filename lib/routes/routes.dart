import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../screens/launching/view/launching_screen.dart';
import '../screens/login/view/login_screen.dart';
import '../screens/register/view/register_screen.dart';
import '../screens/create_password/view/create_password_screen.dart';
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
  ];
}
