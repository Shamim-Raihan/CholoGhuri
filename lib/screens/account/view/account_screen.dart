import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/common_components.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/space_helper.dart';
import '../controller/account_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SpaceHelper.verticalSpace20,
              _buildProfileSection(controller),
              SpaceHelper.verticalSpace24,
              _buildFAQSection(controller),
              SpaceHelper.verticalSpace15,
              _buildPaymentHistorySection(controller),
              SpaceHelper.verticalSpace15,
              _buildSettingsSection(controller),
              SpaceHelper.verticalSpace20,
              _buildLogoutSection(controller),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(AccountController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: ColorHelper.background,
              borderRadius: BorderRadius.circular(97.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(97.r),
              child: Icon(
                Icons.person,
                size: 30.sp,
                color: ColorHelper.textSecondary,
              ),
            ),
          ),
          SpaceHelper.horizontalSpace12,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonComponents().commonText(
                  fontSize: 14,
                  textData: 'Asif Rahman',
                  fontWeight: FontWeight.w500,
                  color: ColorHelper.textPrimary,
                ),
                SpaceHelper.verticalSpace4,
                GestureDetector(
                  onTap: () => controller.navigateToProfile(),
                  child: CommonComponents().commonText(
                    fontSize: 12,
                    textData: 'See Profile',
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(AccountController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: _buildMenuItem(
        iconPath: 'assets/icons/message-search.png',
        title: 'FAQ',
        onTap: () => controller.navigateToFAQ(),
        showBorder: false,
      ),
    );
  }

  Widget _buildPaymentHistorySection(AccountController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: _buildMenuItem(
        iconPath: 'assets/icons/wallet-minus.png',
        title: 'Payment History',
        onTap: () => controller.navigateToPaymentHistory(),
        showBorder: false,
      ),
    );
  }

  Widget _buildSettingsSection(AccountController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.mapBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: _buildMenuItem(
        iconPath: 'assets/icons/setting-2.png',
        title: 'Settings',
        onTap: () => controller.navigateToSettings(),
        showBorder: false,
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    required bool showBorder,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58.h,
        decoration: BoxDecoration(
          border:
              showBorder
                  ? Border(
                    bottom: BorderSide(
                      color: ColorHelper.textSecondary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  )
                  : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              // Icon
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: Image.asset(
                  iconPath,
                  width: 20.w,
                  height: 20.h,
                  color: ColorHelper.primary,
                ),
              ),
              SpaceHelper.horizontalSpace12,
              // Title
              Expanded(
                child: CommonComponents().commonText(
                  fontSize: 14,
                  textData: title,
                  fontWeight: FontWeight.w400,
                  color: ColorHelper.textPrimary,
                ),
              ),
              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: ColorHelper.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutSection(AccountController controller) {
    return Obx(
      () => GestureDetector(
        onTap: controller.isLoadingValue ? null : controller.onLogoutPressed,
        child: Container(
          height: 58.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorHelper.mapBackground,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child:
                controller.isLoadingValue
                    ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorHelper.logoutColor,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/logout.png',
                          height: 24.sp,
                          width: 24.sp,
                          color: ColorHelper.logoutColor,
                        ),
                        SpaceHelper.horizontalSpace8,
                        CommonComponents().commonText(
                          fontSize: 16,
                          textData: 'Log out',
                          fontWeight: FontWeight.w400,
                          color: ColorHelper.logoutColor,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
