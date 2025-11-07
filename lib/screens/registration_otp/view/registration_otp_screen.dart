import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/registration_otp_controller.dart';

class RegistrationOtpScreen extends StatelessWidget {
  const RegistrationOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationOtpController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.navigateBack();
        }
      },
      child: Scaffold(
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
                        _buildOtpForm(controller, context),
                        SpaceHelper.verticalSpace24,
                        _buildVerifyButton(controller),
                        SpaceHelper.verticalSpace20,
                        _buildCountdownTimer(controller),
                        SpaceHelper.verticalSpace15,
                        _buildResendSection(controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(RegistrationOtpController controller) {
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
          textData: 'Verify Mobile Number',
          fontWeight: FontWeight.w600,
          color: ColorHelper.textPrimary,
        ),
        SpaceHelper.verticalSpace8,
        CommonComponents().commonText(
          fontSize: 16,
          textData: 'We have sent a verification code to your mobile number',
          fontWeight: FontWeight.w400,
          maxLine: 3,
          textAlign: TextAlign.start,
          color: ColorHelper.textSecondary,
        ),
      ],
    );
  }

  Widget _buildOtpForm(
    RegistrationOtpController controller,
    BuildContext context,
  ) {
    return Obx(
      () => PinCodeTextField(
        appContext: context,
        length: 6,
        controller: controller.otpController,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.r),
          fieldHeight: 45.h,
          fieldWidth: 46.w,
          activeFillColor: ColorHelper.background,
          inactiveFillColor: ColorHelper.background,
          selectedFillColor: ColorHelper.background,
          activeColor:
              controller.hasError
                  ? Colors.red
                  : ColorHelper.borderColor.withValues(alpha: 0.35),
          inactiveColor: ColorHelper.borderColor.withValues(alpha: 0.35),
          selectedColor: ColorHelper.primary,
          borderWidth: 1.5,
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorHelper.textPrimary,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        onCompleted: controller.onOtpCompleted,
        onChanged: controller.onOtpChanged,
        beforeTextPaste: (text) {
          return RegExp(r'^\d{6}$').hasMatch(text ?? '');
        },
      ),
    );
  }

  Widget _buildCountdownTimer(RegistrationOtpController controller) {
    return Obx(
      () => Center(
        child: CommonComponents().commonText(
          fontSize: 14,
          textData: 'Code expires in ${controller.formattedCountdown}',
          fontWeight: FontWeight.w400,
          color: ColorHelper.textSecondary,
        ),
      ),
    );
  }

  Widget _buildResendSection(RegistrationOtpController controller) {
    return Obx(
      () => Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Didn't received any code? ",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.textSecondary,
                ),
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap:
                      controller.canResend ? controller.onResendPressed : null,
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          controller.canResend
                              ? ColorHelper.primary
                              : ColorHelper.textSecondary,
                      decoration:
                          controller.canResend
                              ? TextDecoration.underline
                              : TextDecoration.none,
                      decorationColor: ColorHelper.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton(RegistrationOtpController controller) {
    return Obx(
      () => CommonComponents().commonButton(
        text: 'Verify',
        onPressed: controller.isFormValid ? controller.onVerifyPressed : () {},
        disabled: !controller.isFormValid,
        isLoading: controller.isLoading,
        fontSize: 16,
      ),
    );
  }
}
