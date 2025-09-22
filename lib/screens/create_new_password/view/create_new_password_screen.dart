import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/create_new_password_controller.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPasswordController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildHeader(controller),
              SpaceHelper.verticalSpace60,
              _buildLogo(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceHelper.verticalSpace40,
                      _buildTitle(),
                      SpaceHelper.verticalSpace24,
                      _buildPasswordForm(controller),
                      SpaceHelper.verticalSpace24,
                      _buildNextButton(controller),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(CreateNewPasswordController controller) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.navigateBack,
            child: Container(
              width: 24.w,
              height: 24.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_ios,
                size: 18.w,
                color: ColorHelper.textPrimary,
              ),
            ),
          ),
        ],
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

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonComponents().commonText(
          fontSize: 24,
          textData: 'Create New Password',
          fontWeight: FontWeight.w600,
          color: ColorHelper.textPrimary,
        ),
        SpaceHelper.verticalSpace8,
        CommonComponents().commonText(
          fontSize: 16,
          textData:
              'Your password reset successfully! Please create new password now',
          fontWeight: FontWeight.w400,
          maxLine: 3,
          textAlign: TextAlign.start,
          color: ColorHelper.textSecondary,
        ),
      ],
    );
  }

  Widget _buildPasswordForm(CreateNewPasswordController controller) {
    return Column(
      children: [
        // Create Password Field
        Obx(
          () => CommonComponents().commonTextField(
            controller: controller.passwordController,
            labelText: 'Create Password',
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
        SpaceHelper.verticalSpace12,

        // Confirm Password Field
        Obx(
          () => CommonComponents().commonTextField(
            controller: controller.confirmPasswordController,
            labelText: 'Confirm Password',
            isPassword: !controller.isConfirmPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: controller.toggleConfirmPasswordVisibility,
              child: Container(
                padding: EdgeInsets.all(12.w),
                child: Icon(
                  controller.isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ColorHelper.textSecondary,
                  size: 24.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(CreateNewPasswordController controller) {
    return Obx(
      () => CommonComponents().commonButton(
        text: 'Next',
        onPressed: controller.isFormValid ? controller.onNextPressed : () {},
        disabled: !controller.isFormValid,
        isLoading: controller.isLoading,
        fontSize: 16,
      ),
    );
  }
}
