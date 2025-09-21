import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SpaceHelper.verticalSpace60,
            _buildLogo(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpaceHelper.verticalSpace40,
                    _buildHeader(),
                    SpaceHelper.verticalSpace40,
                    _buildLoginForm(controller),
                    SpaceHelper.verticalSpace12,
                    _buildForgotPassword(controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      height: 100.h,
      child: Center(
        child: Image.asset('assets/icons/text_logo.png', height: 34.h),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonComponents().commonText(
          fontSize: 24,
          textData: 'Login',
          fontWeight: FontWeight.w600,
          color: ColorHelper.textPrimary,
        ),
        SpaceHelper.verticalSpace8,
        Row(
          children: [
            CommonComponents().commonText(
              fontSize: 16,
              textData: 'New here? ',
              fontWeight: FontWeight.w400,
              color: ColorHelper.textSecondary,
            ),
            GestureDetector(
              onTap: () => Get.find<LoginController>().navigateToRegister(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorHelper.background,
                  borderRadius: BorderRadius.circular(66.r),
                ),
                child: CommonComponents().commonText(
                  fontSize: 14,
                  textData: 'Register',
                  fontWeight: FontWeight.w600,
                  color: ColorHelper.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginForm(LoginController controller) {
    return Column(
      children: [
        // Email/Mobile Field
        CommonComponents().commonTextField(
          controller: controller.emailController,
          labelText: 'Email or mobile number',
          keyboardType: TextInputType.emailAddress,
        ),
        SpaceHelper.verticalSpace12,

        // Password Field
        Obx(
          () => CommonComponents().commonTextField(
            controller: controller.passwordController,
            labelText: 'Password',
            isPassword: !controller.isPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Container(
                padding: EdgeInsets.all(12.w),
                child: Icon(
                  controller.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ColorHelper.textSecondary,
                  size: 24.w,
                ),
              ),
            ),
          ),
        ),
        SpaceHelper.verticalSpace24,

        // Login Button
        Obx(
          () => CommonComponents().commonButton(
            text: 'Log in',
            onPressed:
                controller.isFormValid ? controller.onLoginPressed : () {},
            disabled: !controller.isFormValid,
            isLoading: controller.isLoading,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword(LoginController controller) {
    return Center(
      child: GestureDetector(
        onTap: controller.navigateToForgotPassword,
        child: CommonComponents().commonText(
          fontSize: 16,
          textData: 'Forgot password?',
          fontWeight: FontWeight.w400,
          color: ColorHelper.textPrimary,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
