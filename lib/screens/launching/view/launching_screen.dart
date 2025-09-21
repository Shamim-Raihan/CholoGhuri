import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../helpers/color_helper.dart';
import '../controller/launching_controller.dart';

class LaunchingScreen extends StatelessWidget {
  const LaunchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller which will automatically handle navigation after 3 seconds
    Get.put(LaunchingController());

    return Scaffold(
      backgroundColor: ColorHelper.primary,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: ColorHelper.primary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              SizedBox(height: 50.h),
              // Loading indicator
              SizedBox(
                width: 30.w,
                height: 30.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorHelper.background,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        'assets/icons/logo_with_text.png',
        width: 200.w,
        height: 150.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
