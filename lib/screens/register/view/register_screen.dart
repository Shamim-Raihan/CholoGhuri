import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

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
                    _buildCustomTabSelector(controller),
                    SpaceHelper.verticalSpace24,
                    _buildSelectedForm(controller),
                    SpaceHelper.verticalSpace24,
                    _buildTermsAndConditions(controller),
                    SpaceHelper.verticalSpace24,
                    _buildNextButton(controller),
                    SpaceHelper.verticalSpace24,
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
        child: Image.asset(
          'assets/icons/text_logo.png',
          height: 34.h,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 34.h,
              width: 208.w,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  'CholoGhuri',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorHelper.primary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonComponents().commonText(
          fontSize: 24,
          textData: 'Register',
          fontWeight: FontWeight.w600,
          color: ColorHelper.textPrimary,
        ),
        SpaceHelper.verticalSpace8,
        Row(
          children: [
            CommonComponents().commonText(
              fontSize: 16,
              textData: 'Already have account? ',
              fontWeight: FontWeight.w400,
              color: ColorHelper.textSecondary,
            ),
            GestureDetector(
              onTap: () => Get.find<RegisterController>().navigateToLogin(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorHelper.background,
                  borderRadius: BorderRadius.circular(66.r),
                ),
                child: CommonComponents().commonText(
                  fontSize: 14,
                  textData: 'Login',
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

  Widget _buildCustomTabSelector(RegisterController controller) {
    return Obx(
      () => Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: ColorHelper.borderColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: ColorHelper.borderColor.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(0),
                child: Container(
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedTab == 0
                            ? ColorHelper.primary
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: CommonComponents().commonText(
                      fontSize: 14,
                      textData: 'User',
                      fontWeight:
                          controller.selectedTab == 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                      color:
                          controller.selectedTab == 0
                              ? ColorHelper.background
                              : ColorHelper.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(1),
                child: Container(
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedTab == 1
                            ? ColorHelper.primary
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: CommonComponents().commonText(
                      fontSize: 14,
                      textData: 'Service Provider',
                      fontWeight:
                          controller.selectedTab == 1
                              ? FontWeight.w600
                              : FontWeight.w400,
                      color:
                          controller.selectedTab == 1
                              ? ColorHelper.background
                              : ColorHelper.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedForm(RegisterController controller) {
    return Obx(
      () =>
          controller.selectedTab == 0
              ? _buildUserForm(controller)
              : _buildServiceProviderForm(controller),
    );
  }

  Widget _buildUserForm(RegisterController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 160.w,
                child: CommonComponents().commonTextField(
                  controller: controller.firstNameController,
                  labelText: 'First Name',
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            SpaceHelper.horizontalSpace8,
            Expanded(
              child: SizedBox(
                width: 160.w,
                child: CommonComponents().commonTextField(
                  controller: controller.lastNameController,
                  labelText: 'Last Name',
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
          ],
        ),
        SpaceHelper.verticalSpace12,
        CommonComponents().commonTextField(
          controller: controller.emailController,
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        SpaceHelper.verticalSpace12,
        CommonComponents().commonTextField(
          controller: controller.phoneController,
          labelText: 'Phone',
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildServiceProviderForm(RegisterController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 160.w,
                  child: CommonComponents().commonTextField(
                    controller: controller.serviceFirstNameController,
                    labelText: 'First Name',
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              SpaceHelper.horizontalSpace8,
              Expanded(
                child: SizedBox(
                  width: 160.w,
                  child: CommonComponents().commonTextField(
                    controller: controller.serviceLastNameController,
                    labelText: 'Last Name',
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
            ],
          ),
          SpaceHelper.verticalSpace12,
          CommonComponents().commonTextField(
            controller: controller.serviceEmailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          SpaceHelper.verticalSpace12,
          CommonComponents().commonTextField(
            controller: controller.servicePhoneController,
            labelText: 'Phone',
            keyboardType: TextInputType.phone,
          ),
          SpaceHelper.verticalSpace12,
          CommonComponents().commonTextField(
            controller: controller.organizationNameController,
            labelText: 'Organization Name',
            keyboardType: TextInputType.text,
          ),
          SpaceHelper.verticalSpace12,
          CommonComponents().commonTextField(
            controller: controller.organizationEmailController,
            labelText: 'Organization Email',
            keyboardType: TextInputType.emailAddress,
          ),
          SpaceHelper.verticalSpace12,
          CommonComponents().commonTextField(
            controller: controller.organizationPhoneController,
            labelText: 'Organization Phone',
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions(RegisterController controller) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: controller.toggleTermsAcceptance,
            child: Container(
              width: 18.w,
              height: 18.w,
              margin: EdgeInsets.only(top: 2.h, left: 4.w),
              decoration: BoxDecoration(
                color: ColorHelper.background,
                borderRadius: BorderRadius.circular(3.r),
                border: Border.all(
                  color: ColorHelper.borderColor.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child:
                  controller.isTermsAccepted
                      ? Icon(
                        Icons.check,
                        size: 12.w,
                        color: ColorHelper.primary,
                      )
                      : null,
            ),
          ),
          SpaceHelper.horizontalSpace20,
          Expanded(
            child: GestureDetector(
              onTap: controller.openTermsAndConditions,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.textSecondary,
                  ),
                  children: [
                    const TextSpan(
                      text: 'By signing up you are agreeing to our ',
                    ),
                    TextSpan(
                      text: 'terms and conditions',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorHelper.lightBlue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(RegisterController controller) {
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
