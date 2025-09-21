import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/create_password_controller.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreatePasswordController controller = Get.put(
      CreatePasswordController(),
    );
    final CommonComponents commonComponents = CommonComponents();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceHelper.verticalSpace20,
                _buildBackButton(controller),
                SpaceHelper.verticalSpace40,
                _buildTitle(),
                SpaceHelper.verticalSpace8,
                _buildSubtitle(),
                SpaceHelper.verticalSpace40,
                _buildPasswordField(controller, commonComponents),
                SpaceHelper.verticalSpace20,
                _buildConfirmPasswordField(controller, commonComponents),
                SpaceHelper.verticalSpace8,
                _buildPasswordRequirements(),
                SpaceHelper.verticalSpace12,
                Obx(() => _buildPasswordStrength(controller)),
                SpaceHelper.verticalSpace12,
                Obx(() => _buildPasswordMatchError(controller)),
                SpaceHelper.verticalSpace40,
                Obx(() => _buildNextButton(controller, commonComponents)),
                SpaceHelper.verticalSpace20,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(CreatePasswordController controller) {
    return GestureDetector(
      onTap: controller.navigateBack,
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 20.sp,
        color: ColorHelper.textPrimary,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Create Password',
      style: GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ColorHelper.textPrimary,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Create a secure password for your account',
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorHelper.textSecondary,
      ),
    );
  }

  Widget _buildPasswordField(
    CreatePasswordController controller,
    CommonComponents commonComponents,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Password',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorHelper.textPrimary,
          ),
        ),
        SpaceHelper.verticalSpace8,
        Obx(
          () => commonComponents.commonTextField(
            controller: controller.passwordController,
            labelText: 'Enter your password',
            isPassword: !controller.isPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Icon(
                controller.isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20.sp,
                color: ColorHelper.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField(
    CreatePasswordController controller,
    CommonComponents commonComponents,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorHelper.textPrimary,
          ),
        ),
        SpaceHelper.verticalSpace8,
        Obx(
          () => commonComponents.commonTextField(
            controller: controller.confirmPasswordController,
            labelText: 'Re-enter your password',
            isPassword: !controller.isConfirmPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: controller.toggleConfirmPasswordVisibility,
              child: Icon(
                controller.isConfirmPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20.sp,
                color: ColorHelper.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    return Text(
      'Password must be at least 8 characters',
      style: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ColorHelper.textSecondary,
      ),
    );
  }

  Widget _buildPasswordStrength(CreatePasswordController controller) {
    final strengthText = controller.getPasswordStrengthText();
    if (strengthText.isEmpty) return const SizedBox.shrink();

    Color strengthColor = Colors.grey;
    if (strengthText.contains('Weak')) {
      strengthColor = Colors.red;
    } else if (strengthText.contains('Fair')) {
      strengthColor = Colors.orange;
    } else if (strengthText.contains('Good')) {
      strengthColor = Colors.blue;
    } else if (strengthText.contains('Strong')) {
      strengthColor = Colors.green;
    }

    return Text(
      strengthText,
      style: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: strengthColor,
      ),
    );
  }

  Widget _buildPasswordMatchError(CreatePasswordController controller) {
    final errorText = controller.getPasswordMatchError();
    if (errorText == null) return const SizedBox.shrink();

    return Text(
      errorText,
      style: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.red,
      ),
    );
  }

  Widget _buildNextButton(
    CreatePasswordController controller,
    CommonComponents commonComponents,
  ) {
    return commonComponents.commonButton(
      text: 'Next',
      isLoading: controller.isLoading,
      onPressed:
          controller.isFormValid ? () => controller.onNextPressed() : () {},
    );
  }
}
