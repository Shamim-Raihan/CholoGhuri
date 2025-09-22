import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

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
                      _buildForm(controller),
                      SpaceHelper.verticalSpace60,
                      _buildLoginLink(controller),
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

  Widget _buildHeader(ForgotPasswordController controller) {
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
          textData: 'Forgot Password?',
          fontWeight: FontWeight.w600,
          color: ColorHelper.textPrimary,
        ),
        SpaceHelper.verticalSpace8,
        CommonComponents().commonText(
          fontSize: 16,
          textData: 'Enter your email or mobile number to reset password',
          fontWeight: FontWeight.w400,
          maxLine: 3,
          textAlign: TextAlign.start,
          color: ColorHelper.textSecondary,
        ),
      ],
    );
  }

  Widget _buildForm(ForgotPasswordController controller) {
    return Column(
      children: [
        // Email/Mobile Field
        CommonComponents().commonTextField(
          controller: controller.emailController,
          labelText: 'Email or mobile number',
          keyboardType: TextInputType.emailAddress,
        ),
        SpaceHelper.verticalSpace24,

        // Send Code Button
        Obx(
          () => CommonComponents().commonButton(
            text: 'Send Code',
            onPressed:
                controller.isFormValid ? controller.onSendCodePressed : () {},
            disabled: !controller.isFormValid,
            isLoading: controller.isLoading,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(ForgotPasswordController controller) {
    return Center(
      child: GestureDetector(
        onTap: controller.navigateToLogin,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorHelper.textSecondary.withValues(alpha: 0.56),
              width: 0.56,
            ),
            borderRadius: BorderRadius.circular(60.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonComponents().commonText(
                fontSize: 16,
                textData: 'Login with password ',
                fontWeight: FontWeight.w400,
                color: ColorHelper.textSecondary,
              ),
              CommonComponents().commonText(
                fontSize: 16,
                textData: 'Login',
                fontWeight: FontWeight.w600,
                color: ColorHelper.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
