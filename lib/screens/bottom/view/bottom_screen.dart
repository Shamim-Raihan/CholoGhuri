import 'package:chologhuri/screens/account/view/account_screen.dart';
import 'package:chologhuri/screens/home/view/home_screen.dart';
import 'package:chologhuri/screens/services/view/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/custom_bottom_navigation.dart';
import '../../../components/screen_widgets.dart';
import '../../../helpers/color_helper.dart';
import '../controller/bottom_controller.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(child: Obx(() => _getScreenBody(controller.currentIndex))),
      bottomNavigationBar: Obx(
        () => CustomBottomNavigation(
          currentIndex: controller.currentIndex,
          onTap: controller.changeTab,
        ),
      ),
    );
  }

  Widget _getScreenBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ServicesScreen();
      case 2:
        return const ActivityWidget();
      case 3:
        return const AccountScreen();
      default:
        return const HomeWidget();
    }
  }
}
